RSpec.describe Cleaner::Filesystem do
  describe "#clean!" do
    it "cleans files when found" do
      allow(Dir).to receive('[]').and_return ['','']
      allow(File).to receive(:delete)
      cleaner = Cleaner::Filesystem.new('')

      cleaner.clean!

      expect(File).to have_received(:delete).twice
    end

    it "does not clean files when no files" do
      allow(Dir).to receive('[]').and_return []
      allow(File).to receive(:delete)
      cleaner = Cleaner::Filesystem.new('')

      cleaner.clean!

      expect(File).not_to have_received(:delete)
    end
  end
end