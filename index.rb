require 'sinatra'

require 'mongoid'
Mongoid.load!("#{File.dirname(__FILE__)}/config/mongoid.yml")

# load all the models
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

# load all the routes - no need to be order-specific here
Dir[File.dirname(__FILE__) + '/routes/*.rb'].each {|file| require file }
