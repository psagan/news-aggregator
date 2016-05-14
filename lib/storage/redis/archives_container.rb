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

      def has_archive?(archive_name)
        redis.sismember(ARCHIVES_SET, archive_name)
      end

      def add(archive_name)
        redis.sadd(ARCHIVES_SET, archive_name) unless has_archive?(archive_name)
      end

      private

      attr_reader :redis

    end
  end
end