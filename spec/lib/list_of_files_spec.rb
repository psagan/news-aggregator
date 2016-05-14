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
  end
end


