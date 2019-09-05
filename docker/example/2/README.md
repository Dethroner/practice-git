docker run -d --name=db -e MYSQL_ROOT_PASSWORD=password -v $(pwd)/db-mysql:/var/lib/mysql mysql

docker run -d --name=wp --link=db -p 80:80 -v $(pwd)/themes:/var/www/html/wp-content/themes -e WORDPRESS_DB_HOST=db -e WORDPRESS_DB_PASSWORD=password wordpress
