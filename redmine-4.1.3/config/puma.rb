#!/usr/bin/env puma

# https://gist.github.com/jbradach/6ee5842e5e2543d59adb

# start puma with:
# RAILS_ENV=production bundle exec puma -C ./config/puma.rb

application_path = '/home/redmine/'
directory application_path
environment 'production'
daemonize false
pidfile "#{application_path}/tmp/pids/puma.pid"
state_path "#{application_path}/tmp/pids/puma.state"
stdout_redirect "#{application_path}/log/puma.stdout.log", "#{application_path}/log/puma.stderr.log"
bind 'tcp://0.0.0.0:3000'
#bind "unix://#{application_path}/tmp/sockets/redmine.sock"

workers 1
threads 1,2
