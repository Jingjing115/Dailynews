# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'phantom-blog'
set :repo_url, 'git@git.huantengsmart.com:zhuguo/phantom-blog.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deployer/projects/phantom-blog'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_files, %w{config/secrets.yml config/puma.rb config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :rails_env, 'production'

set :rvm_ruby_version, '2.3.1'

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :test do
  desc 'Test'
  task :test_cap do
    on roles(:all), in: :parallel do |host|
      uptime = capture(:uptime)
      puts "#{host.hostname} reports: #{uptime}"
    end
  end
end

namespace :onm do
  desc 'Update Repo'
  task :fetch_repo do
    on roles(:all) do |host|
      within repo_path do
        execute "cd #{repo_path};git fetch origin master:master;cd -"
      end
    end
  end

  %w{start stop restart}.each do |action|
    desc "#{action} application"
    task action.to_sym do
      invoke "onm:#{action}_rails"
    end
  end

  desc 'Start rails'
  task :start_rails do
    on roles(:app), in: :sequence do
      within release_path do
        execute :bundle, "exec puma --config #{shared_path}/config/puma.rb"
      end
    end
  end

  desc 'Stop rails'
  task :stop_rails do
    on roles(:app), in: :sequence do
      execute :kill, "-INT `cat #{shared_path}/tmp/pids/puma.pid`"
    end
  end

  desc 'Restart rails'
  task :restart_rails do
    on roles(:app), in: :sequence do
      invoke "onm:stop_rails"
      invoke "onm:start_rails"
    end
  end

  desc 'Start sidekiq'
  task :start_sidekiq do
    on roles(:app), in: :sequence do
      within release_path do
        execute :bundle, "exec sidekiq -d -e production -L #{shared_path}/log/sidekiq.log -p #{shared_path}/tmp/pids/sidekiq.pid"
      end
    end
  end

  desc 'Stop sidekiq'
  task :stop_sidekiq do
    on roles(:app), in: :sequence do
      execute :kill, "-INT `cat #{shared_path}/tmp/pids/sidekiq.pid`"
    end
  end

  desc 'Restart sidekiq'
  task :restart_sidekiq do
    on roles(:app), in: :sequence do
      # execute :kill, "-HUP `cat #{shared_path}/tmp/pids/sidekiq.pid`"
      invoke "onm:stop_sidekiq"
      invoke "onm:start_sidekiq"
    end
  end
end

namespace :deploy do
  desc "restart rails"
  after 'deploy:publishing', 'onm:restart_rails'
end
