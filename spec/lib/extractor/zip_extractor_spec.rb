RSpec.describe Extractor::Zip do

  describe "#extract_one" do
    it "saves content by saver" do
      stub_data
      saver = double(:saver, save: true)
      cleaner = double(:cleaner, clean!: true)
      extractor = Extractor::Zip.new(path: '', saver: saver, cleaner: cleaner)

      extractor.extract_one('')

      expect(saver).to have_received(:save)
    end
  end

  describe "#extract" do
    it "extracts multiple files from path" do
      stub_data
      allow(Dir).to receive('[]').and_return(['', ''])
      saver = double(:saver, save: true)
      cleaner = double(:cleaner, clean!: true)
      extractor = Extractor::Zip.new(path: '', saver: saver, cleaner: cleaner)

      extractor.extract

      expect(saver).to have_received(:save).twice
    end
  end

  describe "#extracted_files_count" do
    it "equal to zero by default and when no extraction made" do
      extractor = Extractor::Zip.new(path: '', saver: double(:saver), cleaner: double(:cleaner))

      expect(extractor.extracted_files_count).to eq(0)
    end

    it "counts extracted files when #extract_one in use" do
      stub_data
      saver = double(:saver, save: true)
      cleaner = double(:cleaner, clean!: true)
      extractor = Extractor::Zip.new(path: '', saver: saver, cleaner: cleaner)

      extractor.extract_one('')

      expect(extractor.extracted_files_count).to eq(1)
    end

    it "counts extracted files when #extract in use" do
      stub_data
      allow(Dir).to receive('[]').and_return(['', ''])
      saver = double(:saver, save: true)
      cleaner = double(:cleaner, clean!: true)
      extractor = Extractor::Zip.new(path: '', saver: saver, cleaner: cleaner)

      extractor.extract

      expect(extractor.extracted_files_count).to eq(2)
    end
  end

  def stub_data
    zip_file = double(:zip_file)
    entry = double(:entry, name: true, get_input_stream: double(:is, read: true))
    allow(zip_file).to receive(:glob).and_return([entry])
    allow(::Zip::File).to receive(:open).and_yield(zip_file)
  end

end