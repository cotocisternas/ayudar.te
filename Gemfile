source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'

gem 'mongoid', '~> 6.2.0'

## GEO
gem 'mongoid-geospatial'
gem 'georuby'

## API
gem 'active_model_serializers', '~> 0.10.0'
gem 'rack-cors'
gem 'kaminari-mongoid'

## AUTH
gem 'devise'
gem 'devise-encryptable'
gem 'omniauth-facebook'
gem 'rolify'

## FILES
gem 'carrierwave', '~> 0.11'
gem 'carrierwave-mongoid', :github => 'carrierwaveuploader/carrierwave-mongoid',  :require => 'carrierwave/mongoid'
gem 'carrierwave-aws'
gem 'rmagick'

group :development, :test do
  gem 'fuubar'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'mongoid-rspec', github: 'mongoid-rspec/mongoid-rspec'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'faker'
  gem 'byebug', platform: :mri
  gem 'pry-byebug'
  gem 'rb-inotify'
  gem 'rb-readline'
  gem 'libnotify'
end

group :development do
  gem 'puma', '~> 3.7'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'pry-rails'
  gem 'awesome_print'
  gem 'brakeman', :require => false
end

group :test do
  gem 'simplecov', :require => false
  gem 'database_cleaner'
  gem 'mocha', :require => false
  gem 'resque_spec'
end

gem 'capistrano-rails', group: :development
