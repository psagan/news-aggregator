require_relative 'base'

# Singlethreaded downloader.
# Downloads files one by one.
module Downloader
  class Singlethreaded < Base

    # Singlethreaded - downloads file one by one
    def download_all(file_names)
      file_names.each do |file_name|
        download_one(file_name)
      end
    end
  end
end