require_relative 'helper'

RSpec.describe Downloader::Multithreaded do

  include Spec::Downloader::Helper

  describe "#download_all" do
    it "downloads multiple files" do
      threads = 1
      content, file, downloader = prepare_download(true, {downloader_initialize_params: {number_of_threads: threads}})

      downloader.download_all(['filename1', 'filename2'])

      expect(downloader.downloaded_files).to eq(['filename1', 'filename2'])
    end
  end


end