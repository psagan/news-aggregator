module OnlineFiles
  class ListOfZipFiles
    PATTERN = /\d{13}\.zip/i

    def initialize(host)
      @host = host
    end

    def files
      @files ||= extract_files
    end

    private

    def extract_files
      list = response.body.scan(PATTERN)
      list.uniq
    end

    def response
      unless @response
        res = Net::HTTP.get_response(URI(host))
        raise "Can't access the host" unless res.is_a?(Net::HTTPSuccess)
        @response = res
      end
      @response
    end

    attr_reader :host
  end
end