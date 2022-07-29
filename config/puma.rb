# frozen_string_literal: true

max_threads = 5
max_threads_count = ENV.fetch('RAILS_MAX_THREADS') { max_threads }
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count
development = 'development'
worker_timeout 3600 if ENV.fetch('RAILS_ENV') { development } == development
my_port = 3000
port ENV.fetch('PORT') { my_port }
environment ENV.fetch('RAILS_ENV') { development }
pid_link = 'tmp/pids/server.pid'
pidfile ENV.fetch('PIDFILE') { pid_link }
plugin :tmp_restart
