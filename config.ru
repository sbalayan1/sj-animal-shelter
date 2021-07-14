require 'rack/cors'
require_relative "./config/environment.rb"
<<<<<<< HEAD

=======
>>>>>>> main
use Rack::Cors do
    allow do
        origins '*'
        resource '/*', headers: :any, methods: [:get, :post, :patch, :put, :delete]  
    end
end
<<<<<<< HEAD
=======

>>>>>>> main
run Application.new