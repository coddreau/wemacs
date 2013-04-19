require 'cgi'

class Commands
  
  def initialize(env)
    @params = CGI::parse(env['QUERY_STRING'])
  end  
  
  def project_files
    [200, {'Content-Type' => 'application/json'}, [Dir.glob("*").to_json]]
  end
  
  def file
    file = @params['file'].first.gsub(/^\//,'')
    [200, {'Content-Type' => 'text/plain'}, [File.read(file)]]
  rescue Errno::ENOENT
    [404, {'Content-Type' => 'text/plain'}, ["File #{file} not found."]]
  end
  
end
