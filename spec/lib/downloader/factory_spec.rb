RSpec.describe Downloader::Factory do
  describe "#create" do
    it "creates singlethreaded when no of threads equals 0" do
      singlethreaded = double(:singlethreaded)
      allow(Downloader::Singlethreaded).to receive(:new).and_return(singlethreaded)
      downloader = Downloader::Factory.new(number_of_threads: 0)

      result = downloader.create

      expect(result).to eq(singlethreaded)
    end

    it "creates singlethreaded when no of threads provided" do
      singlethreaded = double(:singlethreaded)
      allow(Downloader::Singlethreaded).to receive(:new).and_return(singlethreaded)
      downloader = Downloader::Factory.new({})

      result = downloader.create

      expect(result).to eq(singlethreaded)
    end

    it "creates multithreaded when no of threads greater than 0" do
      multithreaded = double(:multithreaded)
      allow(Downloader::Multithreaded).to receive(:new).and_return(multithreaded)
      downloader = Downloader::Factory.new(number_of_threads: 1)

      result = downloader.create

      expect(result).to eq(multithreaded)
    end
  end
end