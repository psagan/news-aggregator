RSpec.describe OnlineFiles::ListOfZipFiles do
  describe "#files" do
    it "returns proper list of files" do
      content = '>1234567891123.zip<>1234567891124.zip<'
      communication = double(:http, request: true, success?: true, content: content)

      list_of_files = OnlineFiles::ListOfZipFiles.new(communication)
      files = list_of_files.files

      expect(files).to eq(['1234567891123.zip', '1234567891124.zip'])
    end

    it "raises exception about host when improper host" do
      communication = double(:http, request: true, success?: false)

      list_of_files = OnlineFiles::ListOfZipFiles.new(communication)

      expect { list_of_files.files }.to raise_error(RuntimeError)
      expect { list_of_files.files }.to raise_error("Can't access the host")
    end

    it "returns empty array when no files found in content" do
      content = '>123.zip<>123.zip<'
      communication = double(:http, request: true, success?: true, content: content)

      list_of_files = OnlineFiles::ListOfZipFiles.new(communication)
      files = list_of_files.files

      expect(files).to eq([])
    end

    it "returns unique list of files which names are not duplicated" do

      content = '>1234567891123.zip<>1234567891124.zip<1234567891123.zip'
      communication = double(:http, request: true, success?: true, content: content)

      list_of_files = OnlineFiles::ListOfZipFiles.new(communication)
      files = list_of_files.files

      expect(files).to eq(['1234567891123.zip', '1234567891124.zip'])
    end
  end
end


