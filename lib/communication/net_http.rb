module Communication
  class NetHttp

    def initialize(uri)
      @uri = uri
    end

    def request
      self.response = Net::HTTP.get_response(URI(uri))
    end

    def success?
      response.is_a?(Net::HTTPSuccess)
    end

    def content
      success? ? response.body : ''
    end

    private

    attr_reader :uri
    attr_accessor :response

  end
end