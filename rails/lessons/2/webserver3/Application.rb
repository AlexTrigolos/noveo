require 'rack'
require 'rack/handler/puma'

class Application
  class Base
    attr_reader :routes

    def initialize
      @routes = {}
    end

    def get(path, &handler)
      route('GET', path, &handler)
    end

    def call(env)
      @request = Rack::Request.new(env)
      method = @request.request_method
      path = @request.path_info

      handler = @routes[method][path]

      instance_eval(&handler)
    end

    def params
      @request.params
    end

    private

    def route(method, path, &handler)
      @routes[method] ||= {}
      @routes[method][path] = handler
    end
  end
end

our_app = Application::Base.new

our_app.get '/hello' do
  [200, {}, ["Hello from App. Params: #{params}"]]
end

Rack::Handler::Puma.run(our_app)
