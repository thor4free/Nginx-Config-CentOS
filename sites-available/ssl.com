server {
	# Ports to listen on, uncomment one.
	listen 443 ssl;
	# listen 443 ssl http2;

	# Server name to listen for
	server_name ssl.com;

	# Path to document root
	root /sites/ssl.com/public;

	# Paths to certificate files.
	ssl_certificate /etc/ssl/ssl.com.crt;
	ssl_certificate_key /etc/ssl/ssl.com.key;

	# File to be used as index
	index index.php;

	# Overrides logs defined in nginx.conf, allows per site logs.
	access_log /sites/ssl.com/logs/access.log;
	error_log /sites/ssl.com/logs/error.log;

	# Default server block rules
	include global/server/defaults.conf;

	# SSL rules
	include global/server/ssl.conf;

	location / {
		try_files $uri $uri/ /index.php?$args;
	}

	location ~ \.php$ {
		try_files $uri =404;
		include global/fastcgi-params.conf;

		# Change socket if using PHP pools or PHP 5
		fastcgi_pass unix:/run/php/php7.0-fpm.sock;
		#fastcgi_pass unix:/var/run/php5-fpm.sock;
	}
}

# Redirect http to https
server {
	listen 80;
	server_name ssl.com www.ssl.com;

	return 301 https://ssl.com$request_uri;
}

# Redirect www to non-www
server {
	listen 443;
	server_name www.ssl.com;

	return 301 https://ssl.com$request_uri;
}