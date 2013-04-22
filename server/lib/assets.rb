require 'coffee-script'
require 'slim'

module Assets
  
  def self.compile
    Dir.chdir(ServerRoot) do
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
    end
  end
  
end
