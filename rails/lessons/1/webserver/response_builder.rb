require_relative 'response'

class ResponseBuilder
  def initialize(response:)
    @response = response
  end

  def build
    if @response[:path] == '/'
      respond_with('views/index.html')
    else
      respond_with("views#{@response[:path]}")
    end
  end

  private

  def respond_with(path)
    project_path = "#{__dir__[(Dir.pwd.size + 1)..__dir__.size]}/#{path}"
    if File.exist?(project_path)
      Response.new(code: 200, data: File.binread(project_path))
    else
      Response.new(code: 404)
    end
  end
end
