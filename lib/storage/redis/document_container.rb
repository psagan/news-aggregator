# This class introduces simple interface for operations on document related containers in redis.
module Storage
  module Redis
    class DocumentContainer

      DOCUMENT_NAME_SET = 'DOCUMENT_NAMES'

      DOCUMENT_CONTENT_LIST = 'NEWS_XML'

      def initialize(redis)
        @redis = redis
      end

      # save document if not exists (name is md5 from document content)
      def save(name, content)
        return if document_name_exists?(name)
        save_document_name(name)
        save_content(content)
      end

      private

      def document_name_exists?(name)
        redis.sismember(DOCUMENT_NAME_SET, name)
      end

      def save_document_name(name)
        redis.sadd(DOCUMENT_NAME_SET, name)
      end

      def save_content(content)
        redis.rpush(DOCUMENT_CONTENT_LIST, content)
      end

      attr_reader :redis

    end

  end
end