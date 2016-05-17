# This class is responsible for HTTP communication:
# like making request, testing if request is successful
# and getting response content
module Communication
  class NetHttp

    def initialize(uri)
      @uri = uri
    end

    # make request
    def request
      self.response = Net::HTTP.get_response(URI(uri))
    end

    # check if response has success status
    def success?
      response.is_a?(Net::HTTPSuccess)
    end

    # get response content
    def content
      success? ? response.body : ''
    end

    private

    attr_reader :uri
    attr_accessor :response

  end
end