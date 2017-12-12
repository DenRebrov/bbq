source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'

gem 'devise'

gem 'devise-i18n'

gem 'rails-i18n', '~>5.0.0'

gem 'twitter-bootstrap-rails'

gem 'puma', '~> 3.7'

gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'listen'
  gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
