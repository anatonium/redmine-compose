#!/bin/bash
bundle exec rake generate_secret_token
bundle exec rake db:migrate
bundle exec rake redmine:load_default_data
bundle exec puma -C config/puma.rb
