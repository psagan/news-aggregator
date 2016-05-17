RSpec.describe Storage::Redis::ArchivesContainer do

  describe "#filter_existing" do
    it "filters existing names" do
      files = %w{a b c}
      redis = double(:redis)
      allow(redis).to receive(:sismember) { |set_name, archive_name| archive_name == 'a' }
      redis_container = Storage::Redis::ArchivesContainer.new(redis)

      result = redis_container.filter_existing(files)

      expect(result).to eq(['b', 'c'])
    end
  end

  describe "#add" do
    it "adds data to redis" do
      archive_name = '1234'
      redis = double(:redis, sismember: false)
      redis_container = Storage::Redis::ArchivesContainer.new(redis)
      allow(redis).to receive(:sadd).with(Storage::Redis::ArchivesContainer::ARCHIVES_SET, archive_name)

      redis_container.add(archive_name)

      expect(redis).to have_received(:sadd)
    end

    it "do not add data to redis when name exist" do
      archive_name = '1234'
      redis = double(:redis, sismember: true)
      redis_container = Storage::Redis::ArchivesContainer.new(redis)
      allow(redis).to receive(:sadd).with(Storage::Redis::ArchivesContainer::ARCHIVES_SET, archive_name)

      redis_container.add(archive_name)

      expect(redis).not_to have_received(:sadd)
    end
  end

  describe "#add_all" do
    it "adds all data to redis" do
      archive_names = ['1234', '5678']
      redis = double(:redis, sismember: false)
      redis_container = Storage::Redis::ArchivesContainer.new(redis)
      allow(redis).to receive(:sadd)

      redis_container.add_all(archive_names)

      expect(redis).to have_received(:sadd).twice
    end

    it "do not add data to redis when name exist" do
      archive_names = ['1234', '5678']
      redis = double(:redis, sismember: true)
      allow(redis).to receive(:sadd)
      redis_container = Storage::Redis::ArchivesContainer.new(redis)

      redis_container.add(archive_names)

      expect(redis).not_to have_received(:sadd)
    end
  end

end