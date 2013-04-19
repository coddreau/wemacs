class Commands
  def project_files(env)
    [200, {'Content-Type' => 'application/json'}, [Dir.glob("*").to_json]]
  end
end
