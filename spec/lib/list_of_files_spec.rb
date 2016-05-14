RSpec.describe ListOfFiles do
  describe "#files" do
    it "returns proper list of files" do
      response = double(
          :response,
          is_a?: true,
          body: '>1234567891123.zip<>1234567891124.zip<'
      )
      allow(Net::HTTP).to receive(:get_response).and_return(response)

      list_of_files = ListOfFiles.new('')
      files = list_of_files.files

      expect(files).to eq(['1234567891123.zip', '1234567891124.zip'])
    end

    it "raises exception about host when improper host" do
      response = double(:response, is_a?: false)
      allow(Net::HTTP).to receive(:get_response).and_return(response)

      list_of_files = ListOfFiles.new('')

      expect { list_of_files.files }.to raise_error(RuntimeError)
      expect { list_of_files.files }.to raise_error("Can't access the host")
    end

    it "returns empty array when no files found in body" do
      response = double(
          :response,
          is_a?: true,
          body: '>123.zip<>123.zip<'
      )
      allow(Net::HTTP).to receive(:get_response).and_return(response)

      list_of_files = ListOfFiles.new('')
      files = list_of_files.files

      expect(files).to eq([])
    end

    it "returns unique list of files which names are not duplicated" do
      response = double(
          :response,
          is_a?: true,
          body: '>1234567891123.zip<>1234567891124.zip<1234567891123.zip'
      )
      allow(Net::HTTP).to receive(:get_response).and_return(response)

      list_of_files = ListOfFiles.new('')
      files = list_of_files.files

      expect(files).to eq(['1234567891123.zip', '1234567891124.zip'])
    end
  end
end


