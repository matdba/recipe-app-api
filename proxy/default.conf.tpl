server {
    listen 80;
    server_name matdb.ir www.matdb.ir;

    # Redirect HTTP to HTTPS if it's not already using HTTPS.
    if ($http_x_forwarded_proto = "http") {
        return 301 https://$host$request_uri;
    }

    # Handle static files
    location /static {
        alias /vol/static;
    }

    # Handle dynamic requests (uwsgi to Django app)
    location / {
        include /etc/nginx/uwsgi_params;
        uwsgi_pass app:8000;
        client_max_body_size 10M;
    }
}

server {
    listen 443;  # No need for ssl configuration since Cloudflare handles SSL
    server_name matdb.ir www.matdb.ir;

    # Handle static files
    location /static {
        alias /vol/static;
    }

    # Handle dynamic requests (uwsgi to Django app)
    location / {
        include /etc/nginx/uwsgi_params;
        uwsgi_pass app:8000;
        client_max_body_size 10M;
    }
}
