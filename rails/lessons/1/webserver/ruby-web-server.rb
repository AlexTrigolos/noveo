require 'socket'
require_relative 'request_parser'
require_relative 'response_builder'

class RubyWebServer
  def initialize(hostname: 'localhost', port: 5678)
    @hostname = hostname
    @port = port
    @server = TCPServer.new(hostname, port)
  end

  def start
    notify_client

    loop do
      client = @server.accept
      request = client.readpartial(2048)

      # puts "\n\n", client.class, client.class.ancestors, "\n\n"
      # puts request
      parsed_request = RequestParser.new(request: request).parse
      response = ResponseBuilder.new(response: parsed_request).build

      client.write(response)
      client.close
    end
  end

  private

  def notify_client
    puts "Server is running on #{@hostname}:#{@port}"
  end
end

RubyWebServer.new.start
