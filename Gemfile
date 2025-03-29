source "https://rubygems.org"

# Core gems
gem "rails", "~> 8.0.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false

# API and CORS
gem "rack-cors" 
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "thruster"

# Authentication
gem "devise"
gem "devise-jwt"
gem "bcrypt", "~> 3.1.7"

# Environment and configuration
gem "dotenv-rails", groups: [:development, :test]

# Windows specific
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end


