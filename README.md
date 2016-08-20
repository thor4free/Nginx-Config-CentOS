# Nginx-Config-CentOS WordPress

Este repositorio contiene las configuraciones Nginx utilizados dentro de la serie [Hosting WordPress usted mismo] (https://deliciousbrains.com/hosting-wordpress-setup-secure-virtual-server/). Contiene las mejores prácticas de varias fuentes, incluyendo el [WordPress Codex] (https://codex.wordpress.org/Nginx) y [H5BP] (https://github.com/h5bp/server-configs-nginx). 

Los siguientes sitios de ejemplo se incluyen:

* singlesite.com - solo sitio instalación de WordPress (sin SSL o caché de páginas)
* ssl.com - WordPress en HTTPS
* fastcgi-cache.com - WordPress con [FastCGIcaching](https://deliciousbrains.com/hosting-wordpress-yourself-server-monitoring-caching/#page-cache)
* ssl-fastcgi-cache.com - WordPress en HTTPS con almacenamiento en caché FastCGI
* Multisite-subdomain.com - WordPress multisitio instalar uso de subdominios
* Multisite-subdirectory.com - WordPress multisitio instalar usando subdirectorios


En busca de un entorno de alojamiento moderno aprovisionado usando Ansible? Salida [WordPress Ansible] (https://github.com/A5hleyRich/wordpress-ansible).

## Uso

Puede utilizar estas configuraciones de ejemplo como referencia o directamente mediante la sustitución de su directorio nginx existente. Siga los pasos a continuación para reemplazar la configuración de nginx existente.

Copia de seguridad de cualquier configuración existente:

`sudo mv /etc/nginx /etc/nginx.backup`

Clone the repo:

`sudo git clone https://github.com/thor4free/Nginx-Config-CentOS.git /etc/nginx`

Copiar uno de los ejemplos de configuración de _sites-available_ to _sites-available/yourdomain.com_:

Editar el sitio en consecuencia, prestando especial atención al nombre del servidor y caminos.

Para habilitar el sitio, la configuración de enlace simbólico en el directorio _sites-enabled_ :

`sudo ln -s /etc/nginx/sites-available/yourdomain.com /etc/nginx/sites-enabled/yourdomain.com`

Prueba de la configuración:

`sudo nginx -t`

Si pasa la configuración, reinicie Nginx:

`sudo systemctl start nginx`



## Estructura de directorios


Este repositorio tiene la siguiente estructura, que se basa en las convenciones usadas por un Nginx instalación por defecto en CentOS:


```
.
├── conf.d
├── global
    └── server
├── sites-available
├── sites-enabled
```


__conf.d__ -  configuraciones para los módulos adicionales.

__global__ -  configuraciones dentro del bloque `http`.

__global/server__ -  configuraciones dentro del bloque `server`. El archivo `defaults.conf` debe ser incluida en la mayoría de los sitios, que contiene los valores iniciales adecuados para el almacenamiento en caché, exclusiones de archivos y la seguridad. `files .conf` adicionales se pueden incluir, según sea necesario en función de cada sitio.

__sites-available__ -  configuraciones para sitios individuales (hosts virtuales).

__sites-enabled__ -  enlaces simbólicos en las configuraciones dentro del directorio `sitios-available`. Sólo los sitios que han sido enlace simbólico se cargan.


### Estructura Recomendada para Sitios:

```
.
├── yourdomain1.com
    └── cache
    └── logs
    └── public
├── yourdomain2.com
    └── cache
    └── logs
    └── public
```

