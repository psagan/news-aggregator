# Files cleaner is responsible for cleaning files
module Cleaner
  class Filesystem
    def clean!(filename)
      File.delete(filename)
    end
  end
end