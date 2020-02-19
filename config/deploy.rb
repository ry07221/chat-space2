# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'chat-space2'
set :repo_url,  'git@github.com:ry07221/chat-space2.git'   # どのリポジトリからアプリをpullするかを指定する

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1' #カリキュラム通りに進めた場合、2.5.1 or 2.3.1

set :ssh_options, auth_methods: ['publickey'],     

                  keys: ['~/.ssh/key9.pem']      #どの公開鍵を利用してデプロイするか

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }    #プロセス番号を記載したファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5  #デプロイした最新のアプリ5個をキープ
set :linked_files, %w{ config/secrets.yml }
after 'deploy:publishing', 'deploy:restart'       #デプロイ処理が終わった後、Unicornを再起動するための記述
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'upload secrets.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/secrets.yml', "#{shared_path}/config/secrets.yml")
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end

set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
  AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
  AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"]
}

