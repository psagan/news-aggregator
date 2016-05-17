require 'lib/helpers/loggerable'
module Downloader
  class Base
    include Loggerable

    def initialize(params)
      @host = params.fetch(:host)
      @destination = params.fetch(:destination)
      @communication_class = params.fetch(:communication_class)
      @downloaded_files = []
    end

    def download_one(filename)
      com = communication(host + filename)
      com.request
      unless com.success?
        return info(sprintf('%s - is not accessible', host + filename))
      end
      File.open(File.join(destination, filename), 'wb') do |file|
        file.write(com.content)
      end
      downloaded_files << filename
    end

    def download_all
      raise NotImplementedError.new("#{self.class.name}#download_all is an abstract method.")
    end

    attr_accessor :downloaded_files

    private

    def communication(uri)
      communication_class.new(uri)
    end

    attr_reader :host, :destination, :communication_class

  end
end