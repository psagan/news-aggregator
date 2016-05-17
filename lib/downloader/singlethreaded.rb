require_relative 'base'

module Downloader
  class Singlethreaded < Base
    def download_all(file_names)
      file_names.each do |file_name|
        download_one(file_name)
      end
    end
  end
end