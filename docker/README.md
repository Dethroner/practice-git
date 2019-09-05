# Некоторые Docker команды
## Поиск образа:
docker search nginx
docker search nginx --filter stars=3 --no-trunc busybox

## Получение информации о контейнерах
### Работающие контейнеры:
docker ps

### Работающие и работавшие контейнеры:
docker ps -a

### Логи контейнера:
docker logs infinite

### Информация о контейнере:
docker inspect infinite
docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(docker ps -q)

### События контейнера:
docker events infinite

### Публичные порты:
docker port infinite

### Выполняющиеся процессы:
docker top infinite

### Использование ресурсов:
docker stats infinite

## Запуск и остановка контейнеров
### Запуск остановленного контейнера
docker start nginx

### Остановка
docker stop nginx

### Перезагрузка
docker restart nginx

### Пауза (приостановка всех процессов контейнера)
docker pause nginx

### Снятие паузы
docker unpause nginx

### Блокировка (до остановки контейнера)
docker wait nginx

### Отправка SIGKILL (завершающего сигнала)
docker kill nginx

### Отправка другого сигнала
docker kill -s HUP nginx

### Подключение к существующему контейнеру
docker attach nginx

## Управление образами
### Список образов:
docker images

### Удаление образа:
docker rmi nginx

### Создание образов
docker build .
docker build github.com/creack/docker-firefox
docker build - < Dockerfile
docker build - < context.tar.gz
docker build -t eon/infinite .
docker build -f myOtherDockerfile .
curl example.com/remote/Dockerfile | docker build -f - .

## Работа с томами
### Создние тома без контейнеров
docker volume create my-data

### Создание тома на внешнем хранилище используя [драйвера](https://docs.docker.com/engine/extend/legacy_plugins/#volume-plugins)
docker volume create --driver dostorage --name my-volume

### Подключение тома или хостовой папки к контейнеру
docker run -ti -v my-data:/tmp ubuntu bash
docker run -ti -v $(pwd)/data:/tmp ubuntu bash

## Очистка Docker
### Удаление работающего контейнера
docker rm nginx

### Удаление контейнера и его тома (volume)
docker rm -v nginx

### Удаление всех контейнеров со статусом exited
docker rm $(docker ps -a -f status=exited -q)

### Удаление всех остановленных контейнеров
docker container prune
docker rm `docker ps -a -q`

### Удаление контейнеров, остановленных более суток назад
docker container prune --filter "until=24h"

### Удаление образа
docker rmi nginx

### Удаление неиспользуемых (dangling) образов
docker image prune
docker rmi $(docker images -f dangling=true -q)

### Удаление неиспользуемых (dangling) образов даже с тегами
docker image prune -a

### Удаление всех образов
docker rmi $(docker images -a -q)

### Удаление всех образов без тегов
docker rmi -f $(docker images | grep "^<none>" | awk "{print $3}")

### Остановка и удаление всех контейнеров
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)

### Удаление неиспользуемых (dangling) томов
docker volume prune
docker volume rm $(docker volume ls -f dangling=true -q)

### Удаление неиспользуемых (dangling) томов по фильтру
docker volume prune --filter "label!=keep"

### Удаление неиспользуемых сетей
docker network prune

### Удаление всех неиспользуемых объектов
docker system prune

### По умолчанию для Docker 17.06.1+ тома не удаляются. Чтобы удалились и они тоже:
docker system prune --volumes