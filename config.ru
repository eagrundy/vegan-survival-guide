require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end


# To send PATCH and DELETE requests, I need this:
use Rack::MethodOverride

# Where I mount controllers
use UsersController
use RestaurantsController

run ApplicationController
