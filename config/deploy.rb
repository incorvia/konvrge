# RVM

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'default'
set :rvm_type, :user

# Bundler

require "bundler/capistrano"

# General

ssh_options[:forward_agent] = true

set :application, "konvrge"
set :user, "kevin"

set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :copy

set :use_sudo, false

# Git

set :scm, :git
set :repository,  "git@gitlab.incorvia.me:konvrge.git"
set :branch, "master"

# VPS

role :web, "96.8.120.141"
role :app, "96.8.120.141"
role :db,  "96.8.120.141", :primary => true
role :db,  "96.8.120.141"

# Precompile Assets

load 'deploy/assets'

# Passenger

namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end

# Whenever 

require "whenever/capistrano"

set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer { :production }


