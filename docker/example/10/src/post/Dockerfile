FROM python:3.6.0-alpine

WORKDIR /app
ADD . /app
RUN apk --update add build-base python3-dev --no-cache \
 && pip3 install --upgrade pip \
 && pip3 install -r /app/requirements.txt
ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

CMD ["python3", "post_app.py"]
