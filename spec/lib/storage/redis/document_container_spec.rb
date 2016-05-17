RSpec.describe Storage::Redis::DocumentContainer do
  describe "#save" do
    it "does not save to redis if documen exists" do
      redis = double(:redis, sismember: true, sadd: true, rpush: true)
      saver = Storage::Redis::DocumentContainer.new(redis)

      saver.save('', '')

      expect(redis).not_to have_received(:sadd)
      expect(redis).not_to have_received(:rpush)
    end

    it "saves to redis if document does not exist" do
      redis = double(:redis, sismember: false, sadd: true, rpush: true)
      saver = Storage::Redis::DocumentContainer.new(redis)

      saver.save('', '')

      expect(redis).to have_received(:sadd).once
      expect(redis).to have_received(:rpush).once
    end
  end
end