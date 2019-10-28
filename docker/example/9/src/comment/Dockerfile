FROM ruby:2.2

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . $APP_HOME

RUN apt-get update -qq && apt-get install -y build-essential \
    && bundle install && bundle clean --force \
    && apt-get purge -y build-essential \
    && apt-get autoremove -y && apt-get clean && rm -rf ~/.cache 

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
