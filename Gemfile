source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'

gem 'mongoid', '~> 6.2.0'
gem 'mongoid-enum', :github => 'cotocisternas/mongoid-enum'

## GEO
gem 'mongoid-geospatial'
gem 'georuby'

## API
gem 'active_model_serializers', '~> 0.10.0'
gem 'rack-cors'
gem 'kaminari-mongoid'
gem 'graphql'

## AUTH
gem 'devise'
gem 'devise-encryptable'
gem 'omniauth-facebook'
gem 'rolify'

## FILES
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
# gem 'carrierwave-mongoid', github: 'carrierwaveuploader/carrierwave-mongoid', require: 'carrierwave/mongoid'
# gem 'mongoid-grid_fs'#, github: 'mongoid/mongoid-grid_fs'
# gem 'carrierwave-aws'
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
  gem 'database_cleaner'
  gem 'byebug', platform: :mri
  gem 'pry-byebug'
  gem 'rb-readline'
  case RUBY_PLATFORM
  when /darwin/
    gem 'rb-fsevent'
    gem 'growl'
  when /linux/
    gem 'rb-inotify'
    gem 'libnotify'
  end
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
  gem 'mocha', :require => false
  gem 'resque_spec'
  gem 'codecov', :require => false
end

gem 'capistrano-rails', group: :development
