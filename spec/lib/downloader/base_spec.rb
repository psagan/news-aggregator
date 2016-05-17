require_relative 'helper'

RSpec.describe Downloader::Base do

  include Spec::Downloader::Helper

  describe "#download_one" do
    it "downloads file" do
      content, file, downloader = prepare_download

      downloader.download_one('')

      expect(file).to have_received(:write).with(content)
    end

    it "does not download file" do
      content, file, downloader = prepare_download(false)

      downloader.download_one('')

      expect(file).not_to have_received(:write).with(content)
    end

    it "saves downloaded file name when file properly downloaded" do
      content, file, downloader = prepare_download

      downloader.download_one('filename')

      expect(downloader.downloaded_files).to eq(['filename'])
    end

    it "does not saves downloaded file name when no file downloaded" do
      content, file, downloader = prepare_download(false)

      downloader.download_one('filename')

      expect(downloader.downloaded_files).to eq([])
    end
  end

  describe "#download_all" do
    it "raises exception about not implemented method in abstract" do
      content, file, downloader = prepare_download

      expect { downloader.download_all }.to raise_error(NotImplementedError)
      expect { downloader.download_all }.to raise_error("Downloader::Base#download_all is an abstract method.")
    end
  end

  describe "#downloaded_files_count" do
    it "is equal to zero when no download made" do
      content, file, downloader = prepare_download

      expect(downloader.downloaded_files_count).to eq(0)
    end

    it "returns downloaded files count when #download_one used" do
      content, file, downloader = prepare_download

      downloader.download_one('')

      expect(downloader.downloaded_files_count).to eq(1)
    end
  end

end