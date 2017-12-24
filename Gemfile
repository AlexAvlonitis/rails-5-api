source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers'
gem 'bcrypt'
gem 'jwt'
gem 'mysql2'
gem 'rack-cors', require: 'rack/cors'
gem 'simple_command'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-rails'
  gem 'dotenv-rails'
  gem 'rubocop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails', '~> 3.6'
  gem "factory_bot_rails", "~> 4.0"
  gem 'faker'
  gem "shoulda-matchers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
