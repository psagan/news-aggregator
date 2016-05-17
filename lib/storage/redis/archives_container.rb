module Storage
  module Redis
    class ArchivesContainer

      ARCHIVES_SET = 'ARCHIVES'

      def initialize(redis)
        @redis = redis
      end

      def filter_existing(files)
        files.reject { |file| has_archive?(file) }
      end

      def add_all(files)
        files.each { |file| add(file) }
      end

      def add(archive_name)
        redis.sadd(ARCHIVES_SET, archive_name) unless has_archive?(archive_name)
      end

      private

      def has_archive?(archive_name)
        redis.sismember(ARCHIVES_SET, archive_name)
      end

      attr_reader :redis

    end
  end
end