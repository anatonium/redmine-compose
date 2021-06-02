FROM ruby:2.6.0

# Using wget instead of local files for more reliable installation
# --no-check-certificate due to my VM clock desync

ENV RAILS_ENV production
WORKDIR /home/redmine
RUN apt-get -y update && apt-get -y upgrade && \
  adduser --disabled-login --gecos 'redmine' redmine &&\
  wget --no-check-certificate \
 https://www.redmine.org/releases/redmine-4.1.3.tar.gz \
  && tar --strip-components=1 -xzf redmine-4.1.3.tar.gz

# Configs for puma and db connection

COPY Gemfile Gemfile
COPY redmine-4.1.3/config/database.yml ./config/database.yml
COPY redmine-4.1.3/config/puma.rb ./config/puma.rb
RUN mkdir -p log public/plugin_assets tmp/pids && \
  chown -R redmine:redmine ./ && \
  bundle install --without development test

# .sh script for db migration and starting puma

EXPOSE 3000
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
