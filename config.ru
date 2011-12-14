require 'sprockets'

use Rack::Static, 
  :urls => ["/images", "/javascripts", "/stylesheets"], 
  :root => "public"

project_root = File.expand_path(File.dirname(__FILE__))
assets = Sprockets::Environment.new(project_root) do |env|
  env.logger = Logger.new(STDOUT)
end

assets.append_path(File.join(project_root, 'assets'))

map "/assets" do
  run assets
end

map "/" do
  run lambda { |env|
    [
      200,
      {
        'Content-Type'    => 'text/html',
        'Cache-Control'   => 'public, max-age=86400'
      },
      File.open('public/index.html', File::RDONLY)
    ]
  }
end

# rackup -p 9292 config.ru  