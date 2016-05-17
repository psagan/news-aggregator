module Cleaner
  class Filesystem
    def initialize(path)
      @path = path
    end

    def clean!
      Dir[File.join(path, '*.*')].each { |f| File.delete(f) }
    end

    private

    attr_reader :path
  end
end