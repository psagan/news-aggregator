require_relative 'helper'

RSpec.describe Downloader::Singlethreaded do

  include Spec::Downloader::Helper

  describe "#download_all" do
    it "downloads multiple files" do
      content, file, downloader = prepare_download

      downloader.download_all(['filename1', 'filename2'])

      expect(downloader.downloaded_files).to eq(['filename1', 'filename2'])
    end
  end
end