docker run -d --name=db -e MYSQL_ROOT_PASSWORD=password mysql:5.7

docker run -d --name=wp --link=db -p 80:80 -e WORDPRESS_DB_HOST=db -e WORDPRESS_DB_PASSWORD=password wordpress:4.7
