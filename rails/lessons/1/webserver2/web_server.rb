require 'rack'
require 'puma'

class WebServer
  def call(env)
    [200, { 'Content-Type' => 'text/html' }, ['<h1>Hello World</h1>']]
    # [200, { 'Content-Type' => 'text/html' }, env]
  end
end

Rack::Handler::Puma.run(WebServer.new)
