source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# зависим от рельсов 5.1.*
gem 'rails', '~> 5.1.4'

# гем, предоставляющий возможности для аутентификации в rails-приложениях
gem 'devise'

# гем для перевода сообщений девайса
gem 'devise-i18n'
gem 'rails-i18n', '~>5.0.0'

# гем, интегрирующий bootstrap
gem 'twitter-bootstrap-rails'

# используй гем puma в качестве сервера приложений
gem 'puma', '~> 3.7'

# используй гем Uglifier для сжатия ресурсов JavaScript
gem 'uglifier', '>= 1.3.0'

# гем для поддержки jquery
gem 'jquery-rails'

# гем для загрузки картинок
gem 'carrierwave'

# гем для обработки картинок
gem 'rmagick'

# гем для работы carrierwave с хранилищем Amazon S3
gem 'fog-aws'

# гем для загрузки переменных среды из .env в ENV в процессе разработки
gem 'dotenv-rails'

# в продакшен сервере heroku этот гем соединяет с базой данных Postgres
group :production do
  gem 'pg'
end

group :development, :test do
  gem 'listen'
   # Гем для работы c sqlite3
  gem 'sqlite3'

  # Гем для дебага
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

# Windows не включает в себя файлы zoneinfo, поэтому свяжите гем tzinfo-data
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
