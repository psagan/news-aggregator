class ListOfFiles
  PATTERN = /\d{13}\.zip/i

  def initialize(host)
    @host = host
  end

  def files
    @files ||= response.body.scan(PATTERN)
  end

  private

  def response
    unless @response
      res = Net::HTTP.get_response(URI(host))
      unless res.is_a?(Net::HTTPSuccess)
        raise "Can't access the host"
      end
      @response = res
    end
    @response
  end

  attr_reader :host
end