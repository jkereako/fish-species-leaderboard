source 'https://rubygems.org'
ruby '2.1.5'

#-- Rails
gem 'rails'

#-- Assets
gem 'sass-rails'    # Sass support
gem 'uglifier'      # Concatenate and minify
gem 'coffee-rails'  # CoffeeScript support
gem 'jquery-rails'  # jQuery library
gem 'turbolinks'
gem 'jbuilder'      # Easily build JSON

#-- File upload
gem 'paperclip'

#-- User management
gem 'devise'            # Complete user management
gem 'devise_invitable'  # Add user invitation s to Devise
gem 'pundit'            # Define user polcies

#-- Documentation
gem 'sdoc', group: :doc

group :development, :test do
  gem 'brakeman'
  gem 'quiet_assets'        # Disallow assets in the log
  gem 'sqlite3'
  gem 'byebug'              # Call `byebug` anywhere in code to stop execution
  gem 'better_errors'       # Display robust errors in the browser
  gem 'web-console'         # Acceess IRB by typing <%= console %> in views
  gem 'spring'
  gem 'factory_girl_rails'  # Generate models and by-passing validation
  gem 'rspec-rails'         # The most popular testing framework
end

group :development, :staging do
  gem 'letter_opener'       # Preview mailer templates in development
end

# see: http://stackoverflow.com/questions/28374401/nameerror-uninitialized-constant-paperclipstorages3aws#28376678
group :production, :staging do
  gem 'aws-sdk', '< 2.0'        # Amazon Web Services
end

group :production do
  gem 'pg'              # PostgreSQL
  gem 'puma'            # The Puma web server
  gem 'rails_12factor'  # Heroku
end
