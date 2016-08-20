server {
	# Ports to listen on
	listen 80;

	# Server name to listen for
	server_name multisite-subdomain.com *.multisite-subdomain.com;

	# Path to document root
	root /sites/multisite-subdomain.com/public;

	# File to be used as index
	index index.php;

	# Overrides logs defined in nginx.conf, allows per site logs.
	access_log /sites/multisite-subdomain.com/logs/access.log;
	error_log /sites/multisite-subdomain.com/logs/error.log;

	# Default server block rules
	include global/server/defaults.conf;

	location / {
		try_files $uri $uri/ /index.php?$args;
	}

	location ~ \.php$ {
		try_files $uri =404;
		include global/fastcgi-params.conf;

		# Change socket if using PHP pools or PHP 5
		#fastcgi_pass unix:/run/php/php7.0-fpm.sock;
		fastcgi_pass unix:/var/run/php-fpm.sock;
	}
}

# Redirect www to non-www
server {
	listen 80;
	server_name www.multisite-subdomain.com;

	return 301 $scheme://multisite-subdomain.com$request_uri;
}
