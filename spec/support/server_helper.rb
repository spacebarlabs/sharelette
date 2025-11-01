# Start a simple WEBrick file server to serve repository root for system tests
require "webrick"

module ServerHelper
  def self.start(dir:, port: 4000)
    root = File.expand_path(dir)
    server = WEBrick::HTTPServer.new(
      Port: port,
      DocumentRoot: root,
      AccessLog: [],
      Logger: WEBrick::Log.new(File::NULL)
    )

    thread = Thread.new { server.start }
    at_exit { server.shutdown }
    return server, thread
  end
end

