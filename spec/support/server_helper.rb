require 'webrick'

module ServerHelper
  @server = nil
  @thread = nil

  def self.start
    return if @server

    # Serve the repository root on port 4000
    doc_root = File.expand_path('../..', __dir__)
    puts "Starting WEBrick server with DocumentRoot: #{doc_root}" if ENV['DEBUG']
    
    @server = WEBrick::HTTPServer.new(
      Port: 4000,
      DocumentRoot: doc_root,
      Logger: WEBrick::Log.new('/dev/null'),
      AccessLog: []
    )

    @thread = Thread.new { @server.start }

    # Wait for server to be ready
    sleep 1
  end

  def self.stop
    return unless @server

    @server.shutdown
    @thread.join if @thread
    @server = nil
    @thread = nil
  end
end
