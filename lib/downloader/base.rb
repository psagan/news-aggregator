require 'lib/helpers/loggerable'

# This class is abstract class for downloaders
# Responsible for downloading files.
module Downloader
  class Base
    include Loggerable

    attr_accessor :downloaded_files

    def initialize(params)
      @host = params.fetch(:host)
      @destination = params.fetch(:destination)
      @communication_class = params.fetch(:communication_class)
      @downloaded_files = []
    end

    # download one file
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

    # abstract method which should be implemented in subclasses
    def download_all
      raise NotImplementedError.new("#{self.class.name}#download_all is an abstract method.")
    end

    # count downloaded files
    def downloaded_files_count
      downloaded_files.length
    end

    private

    # get new instances of communication class
    def communication(uri)
      communication_class.new(uri)
    end

    attr_reader :host, :destination, :communication_class

  end
end