FROM ruby:2.4-alpine3.9

ENV APP_HOME /app
WORKDIR $APP_HOME

RUN wget -qO- https://github.com/express42/reddit/archive/microservices.zip | \
    busybox unzip - 'reddit-microservices/ui/*' && \
    mv reddit-microservices/ui/* . && rm -rf reddit-microservices && \
    apk add --no-cache build-base  && bundle install && \
    bundle clean && rm -rf ~/.bundle && apk del build-base

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]
