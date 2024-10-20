#!/bin/bash

# Variables
PROMETHEUS_VERSION="2.42.0"  
ALERTMANAGER_VERSION="0.24.0"  
SES_EMAIL="omar.mostafa.contact@gmail.com.com"
SMTP_USERNAME="AKIAVIOZGBGYS7N5YVEO"  
SMTP_PASSWORD="BIqXtLm/C32/qtS/XW5B1fECuFFbKoxgp8sxFw0C8imf"  
INSTANCE_IP=$(curl -s http://18.212.119.98/latest/meta-data/public-ipv4)

# Update and install dependencies
sudo apt-get update
sudo apt-get install -y wget curl

# Download and install Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v$PROMETHEUS_VERSION/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz
tar xvf prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz
sudo mv prometheus-$PROMETHEUS_VERSION.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-$PROMETHEUS_VERSION.linux-amd64/promtool /usr/local/bin/
sudo mkdir /etc/prometheus
sudo mv prometheus-$PROMETHEUS_VERSION.linux-amd64/consoles /etc/prometheus
sudo mv prometheus-$PROMETHEUS_VERSION.linux-amd64/console_libraries /etc/prometheus

# Prometheus configuration
cat <<EOL | sudo tee /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

alerting:
  alertmanagers:
    - static_configs:
        - targets: ['localhost:9093']
EOL

# Create systemd service for Prometheus
cat <<EOL | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=root
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --web.listen-address=0.0.0.0:9090
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Start and enable Prometheus
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus

# Download and install Alertmanager
wget https://github.com/prometheus/alertmanager/releases/download/v$ALERTMANAGER_VERSION/alertmanager-$ALERTMANAGER_VERSION.linux-amd64.tar.gz
tar xvf alertmanager-$ALERTMANAGER_VERSION.linux-amd64.tar.gz
sudo mv alertmanager-$ALERTMANAGER_VERSION.linux-amd64/alertmanager /usr/local/bin/
sudo mv alertmanager-$ALERTMANAGER_VERSION.linux-amd64/amtool /usr/local/bin/
sudo mkdir /etc/alertmanager

# Alertmanager configuration
cat <<EOL | sudo tee /etc/alertmanager/config.yml
global:
  smtp_smarthost: 'email-smtp.us-east-1.amazonaws.com:587'  # Update region if necessary
  smtp_from: '$SES_EMAIL'
  smtp_auth_username: '$SMTP_USERNAME'
  smtp_auth_password: '$SMTP_PASSWORD'
  
route:
  receiver: 'email_alerts'

receivers:
  - name: 'email_alerts'
    email_configs:
      - to: '$SES_EMAIL'
        from: '$SES_EMAIL'
        subject: '[Alert] Prometheus Alert'
EOL

# Create systemd service for Alertmanager
cat <<EOL | sudo tee /etc/systemd/system/alertmanager.service
[Unit]
Description=Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=root
ExecStart=/usr/local/bin/alertmanager --config.file=/etc/alertmanager/config.yml --web.listen-address=0.0.0.0:9093
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Start and enable Alertmanager
sudo systemctl daemon-reload
sudo systemctl start alertmanager
sudo systemctl enable alertmanager

# Create a simple alert rule
cat <<EOL | sudo tee /etc/prometheus/alert.rules
groups:
- name: example-alert
  rules:
  - alert: HighCPUUsage
    expr: sum(rate(cpu_usage_seconds_total[1m])) by (instance) > 0.9
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: "High CPU Usage on {{ $labels.instance }}"
      description: "CPU usage is above 90% for more than 5 minutes."
EOL

# Update Prometheus configuration to include the alert rules
sudo sed -i '/^rule_files:/a - "/etc/prometheus/alert.rules"' /etc/prometheus/prometheus.yml

# Restart Prometheus to apply changes
sudo systemctl restart prometheus

# Test installation
echo "Prometheus is running at http://$INSTANCE_IP:9090"

