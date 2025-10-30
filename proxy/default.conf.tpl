server {
    listen 80;
    server_name matdb.ir www.matdb.ir;

    # Handle static files
    location /static {
        alias /vol/static;
    }

    # Handle dynamic requests (uwsgi to Django app)
    location / {
        uwsgi_pass           ${APP_HOST}:${APP_PORT};
        include              /etc/nginx/uwsgi_params;
        client_max_body_size 10M;
    }
}

server {
    listen 443;
    server_name matdb.ir www.matdb.ir;

    # Handle static files
    location /static {
        alias /vol/static;
    }

    # Handle dynamic requests (uwsgi to Django app)
    location / {
        uwsgi_pass           ${APP_HOST}:${APP_PORT};
        include              /etc/nginx/uwsgi_params;
        client_max_body_size 10M;
    }
}
