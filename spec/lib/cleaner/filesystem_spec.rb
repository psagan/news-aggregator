RSpec.describe Cleaner::Filesystem do
  describe "#clean!" do
    it "cleans files" do
      allow(File).to receive(:delete)
      cleaner = Cleaner::Filesystem.new
      filename = 'xxx'

      cleaner.clean!(filename)

      expect(File).to have_received(:delete).with(filename)
    end
  end
end