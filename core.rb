require 'mongoid'
Mongoid.load!("#{File.dirname(__FILE__)}/config/mongoid.yml")

# load all the models
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }
