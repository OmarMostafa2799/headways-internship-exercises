##for instance 1 and 2

sudo yum update -y
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

##for instance 1 

sudo nano /etc/nginx/nginx.conf

server {
    listen 80;
    server_name localhost;

    location / {
        default_type text/html;
        return 200 "<html><h1>Hi, I am from instance number 1</h1></html>";
    }
}


##for instance 2

sudo nano /etc/nginx/nginx.conf

server {
    listen 80;
    server_name localhost;

    location / {
        default_type text/html;
        return 200 "<html><h1>Hi, I am from instance number 2</h1></html>";
    }
}
