require 'coffee-script'
require 'slim'

Dir.glob('javascripts/**/*.coffee').each do |coffee|
  js = CoffeeScript.compile(File.read(coffee))
  File.write(coffee.sub(/coffee$/, 'js'), js)
end

Dir.glob('stylesheets/**/*.sass').each do |sass|
  css = sass.sub(/sass$/, 'css')
  system "sass #{sass}:#{css}"
end

Dir.glob('views/**/*.slim').each do |slim|
  html = File.basename(slim).sub(/slim$/, 'html')
  html = "public/#{html}"
  File.write(html, Slim::Template.new(slim).render(html))
end

class WEmacs
  def call(env)
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
