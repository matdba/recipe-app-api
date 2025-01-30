server {
    listen 80;
    server_name matdb.ir www.matdb.ir;

    # Redirect HTTP to HTTPS (for users connecting via Cloudflare)
    return 301 https://$host$request_uri;
}

server {
    listen 443;
    server_name matdb.ir www.matdb.ir;

    # No need for SSL certificates when using Flexible SSL in Cloudflare
    # Traffic between Cloudflare and the server is HTTP

    location /static {
        alias /vol/static;
    }

    location / {
        uwsgi_pass           ${APP_HOST}:${APP_PORT};
        include              /etc/nginx/uwsgi_params;
        client_max_body_size 10M;
    }
}