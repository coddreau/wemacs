require 'json'
require './lib/assets'

class WEmacs
  def call(env)
    Assets.compile
    asset_request?(env) ? serve_asset(env) : serve_command(env)
  end
  
  def asset_request?(env)
    env["PATH_INFO"] =~ /^\/$|\.(js|css|html)$/
  end
  
  def serve_command(env)
    load './lib/commands.rb'
    Commands.new.send(env["PATH_INFO"][/(\w+)$/, 1], env)
  end
  
  def serve_asset(env)
    @url = env["PATH_INFO"]
    file = @url == '/' ? 'main.html' : @url[1..-1]
    extension = file[/\.(\w+)$/, 1]
    content_type = { 'js' => 'application/javascript',
                     'css' => 'text/css',
                     'html' => 'text/html' }[extension]
    file = "public/#{file}" if extension == 'html'
    [200, {'Content-Type' => content_type}, [File.read(file)]]
  end
end

run WEmacs.new
