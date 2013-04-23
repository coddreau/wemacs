require 'json'
require './lib/assets'

ServerRoot = File.dirname(__FILE__)

class WEmacs
  def call(env)
    Assets.compile
    asset_request?(env) ? serve_asset(env) : run_command(env)
  end
  
  def asset_request?(env)
    env["PATH_INFO"] =~ /^\/$|\.(js|css|html)$/
  end
  
  def run_command(env)
    load "#{ServerRoot}/lib/commands.rb"
    command = env["PATH_INFO"][/(\w+)$/, 1]
    Commands.new(env).send(command)
  end
  
  def serve_asset(env)
    @url = env["PATH_INFO"]
    file = @url == '/' ? 'main.html' : @url[1..-1]
    extension = file[/\.(\w+)$/, 1]
    content_type = { 'js' => 'application/javascript',
                     'css' => 'text/css',
                     'html' => 'text/html' }[extension]
    file = "public/#{file}" if extension == 'html'
    full_path = [ServerRoot, file].join('/')
    [200, {'Content-Type' => content_type}, [File.read(full_path)]]
  end
end

run WEmacs.new