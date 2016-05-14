RSpec.describe Storage::Redis::ArchivesContainer do
  describe "#has_archive?" do
    it "returns true if archive exists" do
      archive_name = '1234'
      redis = double(:redis)
      redis_container = Storage::Redis::ArchivesContainer.new(redis)
      allow(redis).to receive(:sismember).with(Storage::Redis::ArchivesContainer::ARCHIVES_SET, archive_name).and_return(true)

      result = redis_container.has_archive?(archive_name)

      expect(result).to eq(true)
      expect(redis).to have_received(:sismember)
    end

    it "returns false if archive does not exist" do
      archive_name = '1234'
      redis = double(:redis)
      redis_container = Storage::Redis::ArchivesContainer.new(redis)
      allow(redis).to receive(:sismember).with(Storage::Redis::ArchivesContainer::ARCHIVES_SET, archive_name).and_return(false)

      result = redis_container.has_archive?(archive_name)

      expect(result).to eq(false)
      expect(redis).to have_received(:sismember)
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

  describe "#filter_existing" do
    it "filters existing names" do
      files = ['a', 'b', 'c']
      redis = double(:redis)
      allow(redis).to receive(:sismember) { |set_name, archive_name| archive_name == 'a' }
      redis_container = Storage::Redis::ArchivesContainer.new(redis)

      result = redis_container.filter_existing(files)

      expect(result).to eq(['b', 'c'])
    end
  end

end