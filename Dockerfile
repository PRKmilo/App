FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
run mkdir /merca2
workdir /merca2
copy Gemfile /merca2/Gemfile
copy Gemfile.lock /merca2/Gemfile.lock
RUN bundle install
copy . /merca2

