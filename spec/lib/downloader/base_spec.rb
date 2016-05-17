RSpec.describe Downloader::Base do
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

  def prepare_download(success = true)
    content = double(:content, to_sym: '')
    communication = double(:http, request: true, success?: success, content: content)
    communication_class = double(:communication_class, new: communication)
    file = double(:file)
    allow(file).to receive(:write)
    allow(File).to receive(:open).and_yield(file)
    allow(Logger).to receive(:new).and_return(double(:logger, info: true))
    downloader = Downloader::Base.new(host: '', destination: '', communication_class: communication_class)

    return content, file, downloader
  end
end