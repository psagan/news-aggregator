RSpec.describe Communication::NetHttp do
  describe "#success?" do
    it "returns true when response is successful" do
      communication = Communication::NetHttp.new('')
      response = double(:response, is_a?: true)
      allow(Net::HTTP).to receive(:get_response).and_return(response)

      communication.request

      expect(communication.success?).to eq(true)
    end

    it "returns false when response is not successful" do
      communication = Communication::NetHttp.new('')
      response = double(:response, is_a?: false)
      allow(Net::HTTP).to receive(:get_response).and_return(response)

      communication.request

      expect(communication.success?).to eq(false)
    end
  end

  describe "#content" do
    it "returns body when response is successful" do
      body = '<html>'
      communication = Communication::NetHttp.new('')
      response = double(:response, is_a?: true, body: body)
      allow(Net::HTTP).to receive(:get_response).and_return(response)

      communication.request

      expect(communication.content).to eq(body)
    end

    it "returns empty string when response is not successful" do
      body = '<html>'
      communication = Communication::NetHttp.new('')
      response = double(:response, is_a?: false, body: body)
      allow(Net::HTTP).to receive(:get_response).and_return(response)

      communication.request

      expect(communication.content).to eq('')
    end
  end
end