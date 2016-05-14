# this is simple autoloader for this small application

# add current path to $LOAD_PATH
$: << File.join(File.dirname(__FILE__))

# load all lib files
Dir[File.join('lib', '**', '*.rb')].each {|file| require file }