RSpec.describe Storage::Redis::ArchivesContainer do
  describe "#has_archive?" do
    it "returns true if archive exists" do
      archive_name = '1234'
      redis = double(:storage)
      redis_container = Storage::Redis::ArchivesContainer.new(redis)
      allow(redis).to receive(:sismember).with(Storage::Redis::ArchivesContainer::ARCHIVES_SET, archive_name).and_return(true)

      result = redis_container.has_archive?(archive_name)

      expect(result).to eq(true)
      expect(redis).to have_received(:sismember)
    end

    it "returns false if archive does not exist" do
      archive_name = '1234'
      redis = double(:storage)
      redis_container = Storage::Redis::ArchivesContainer.new(redis)
      allow(redis).to receive(:sismember).with(Storage::Redis::ArchivesContainer::ARCHIVES_SET, archive_name).and_return(false)

      result = redis_container.has_archive?(archive_name)

      expect(result).to eq(false)
      expect(redis).to have_received(:sismember)
    end

  end

  describe "#add" do

  end
end