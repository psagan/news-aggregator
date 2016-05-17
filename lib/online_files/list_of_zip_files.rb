# This class is responsible for getting list of zip files available online.
module OnlineFiles
  class ListOfZipFiles

    PATTERN = /\d{13}\.zip/i

    def initialize(communication)
      @communication = communication
    end

    def files
      @files ||= get_files
    end

    private

    def get_files
      request_for_files
      files = extract_files_from_response
      decorate(files)
    end

    def request_for_files
      communication.request
      raise "Can't access the host" unless communication.success?
    end

    def extract_files_from_response
      communication.content.scan(PATTERN)
    end

    def decorate(files)
      files.uniq
    end

    attr_reader :communication
  end
end