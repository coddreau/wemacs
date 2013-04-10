class WEmacs
  def call(env)
    @url = env["PATH_INFO"]
    file = @url == '/' ? 'main.html' : @url[1..-1]
    extension = file[/\.(\w+)$/, 1]
    content_type = { 'js' => 'application/javascript',
                     'html' => 'text/html' }[extension]
    [200, {'Content-Type' => content_type}, [File.read(file)]]
  end
end

run WEmacs.new
