FROM ruby:2.3.1-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential libsqlite3-dev nodejs

ENV APP_PATH /usr/src/app
RUN mkdir -p /usr/src/app

COPY Gemfile $APP_PATH
COPY Gemfile.lock $APP_PATH

WORKDIR ${APP_PATH}

RUN bundle install

COPY . $APP_PATH

RUN bin/rake db:migrate 

RUN bin/rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]