RSpec.describe Aggregator do
  describe "#run" do

    it "runs everything in proper order" do
      files = double(:files)
      filtered_files = double(:filtered_files)
      downloaded_files = double(:downloaded_files)
      online_files = double(:online_files, files: files)
      archives_container = double(:archives_container, filter_existing: filtered_files, add_all: true)
      downloader = double(:downloader, download_all: true, downloaded_files: downloaded_files)
      extractor = double(:extractor, extract: true)
      cleaner = double(:cleaner, clean!: true)
      aggregator = Aggregator.new({
        online_files: online_files,
        archives_container: archives_container,
        downloader: downloader,
        extractor: extractor,
        cleaner: cleaner
      })

      aggregator.run

      expect(online_files).to have_received(:files)
      expect(archives_container).to have_received(:filter_existing).with(files)
      expect(downloader).to have_received(:download_all).with(filtered_files)
      expect(archives_container).to have_received(:add_all).with(downloaded_files)
      expect(extractor).to have_received(:extract)
      expect(cleaner).to have_received(:clean!)
    end

  end
end