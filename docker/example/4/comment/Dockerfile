FROM ruby:2.4-alpine3.9

ENV APP_HOME /app
WORKDIR $APP_HOME

RUN wget -qO- https://github.com/express42/reddit/archive/microservices.zip | \
    busybox unzip - 'reddit-microservices/comment/*' && \
    mv reddit-microservices/comment/* . && rm -rf reddit-microservices && \
    apk add --no-cache build-base && bundle install && \
    bundle clean && rm -rf ~/.bundle && apk del build-base

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
