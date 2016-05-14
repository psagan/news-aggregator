# this is simple autoloader for this small application

# require gems
require 'rubygems'
require 'zip'
require 'net/http'
require 'redis'

# add current path to $LOAD_PATH
$: << File.join(File.dirname(__FILE__))

# load all lib files
Dir[File.join('lib', '**', '*.rb')].each {|file| require file }