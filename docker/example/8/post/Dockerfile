FROM python:3.6.0-alpine

WORKDIR /app
COPY . /app

RUN apk add g++ --no-cache && pip install -r requirements.txt \
&& apk del g++ && rm -rf /root/.cache

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

ENTRYPOINT ["python3", "post_app.py"]
