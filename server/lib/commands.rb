class Commands
  
  def initialize(env)
    @params = Rack::Request.new(env).params
  end  
  
  def project_files
    filter = (@params['filter'] if @params['filter'].to_s.strip != '')
    files = Dir.glob("#{ServerRoot}/**/*").map{|f| File.basename f}
    files.select!{|f| f =~ /#{filter}/} if filter
    [200, {'Content-Type' => 'application/json'}, [files.sort.to_json]]
  end
  
  def file
    file = @params['file'].gsub(/^\//,'')
    file = "#{ServerRoot}/#{file}"
    [200, {'Content-Type' => 'text/plain'}, [File.read(file)]]
  rescue Errno::ENOENT
    [404, {'Content-Type' => 'text/plain'}, ["File #{file} not found."]]
  end
  
  def save
    file = @params['file'].gsub(/^\//,'')
    file = "#{ServerRoot}/#{file}"
    content = @params['content']
    File.write file, content
    [200, {'Content-Type' => 'text/plain'}, ["Ok"]]
  end
  
end
