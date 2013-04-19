class Commands
  
  def initialize(env)
    @params = Rack::Request.new(env).params
  end  
  
  def project_files
    [200, {'Content-Type' => 'application/json'}, [Dir.glob("*").to_json]]
  end
  
  def file
    file = @params['file'].gsub(/^\//,'')
    [200, {'Content-Type' => 'text/plain'}, [File.read(file)]]
  rescue Errno::ENOENT
    [404, {'Content-Type' => 'text/plain'}, ["File #{file} not found."]]
  end
  
  def save
    file = @params['file'].gsub(/^\//,'')
    content = @params['content']
    File.write file, content
    [200, {'Content-Type' => 'text/plain'}, ["Ok"]]
  end
  
end
