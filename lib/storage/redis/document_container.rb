module Storage
  module Redis
    class DocumentContainer

      DOCUMENT_NAME_SET = 'DOCUMENT_NAMES'

      DOCUMENT_CONTENT_LIST = 'NEWS_XML'

      def initialize(redis)
        @redis = redis
      end

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
        p name
        redis.sadd(DOCUMENT_NAME_SET, name)
      end

      def save_content(content)
        redis.rpush(DOCUMENT_CONTENT_LIST, content)
      end

      attr_reader :redis

    end

  end
end