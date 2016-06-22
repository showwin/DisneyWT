set :stage, :production
set :rails_env, 'production'
set :deploy_to, '/var/www/DisneyWT'
set :config_path, 'config'
set :unicorn_pid, -> { File.join(shared_path, 'tmp', 'pids', 'disneywt.pid') }
set :unicorn_config_path, 'config/unicorn.rb'
set :unicorn_rack_env, 'production'
set :unicorn_restart_sleep_time, 3
server 'disneywt', roles: %w(web app db)
