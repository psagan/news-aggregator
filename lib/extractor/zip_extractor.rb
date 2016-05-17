class Extractor
  class Zip

    attr_reader :extracted_files_count

    # pattern to detect archives (this class is responsible
    # for ZIP archives)
    ARCHIVE_PATTERN = '*.zip'

    # pattern to detect xml documents inside every archive
    DOCUMENT_PATTERN = File.join('**', '*.xml')

    def initialize(path, saver)
      @path = path
      @saver = saver
      @extracted_files_count = 0
    end

    def extract
      files_from_path.each do |file|
        extract_one(file)
      end
    end

    def extract_one(file)
      ::Zip::File.open(file) do |zip_file|
        zip_file.glob(DOCUMENT_PATTERN).each do |entry|
          # use strategy pattern to save extracted data
          # rule tell, don't ask applied here
          saver.save(entry.name, entry.get_input_stream.read)
          post_save
        end
      end
    end

    private

    def post_save
      increment_extracted_files_count
    end

    def increment_extracted_files_count
      self.extracted_files_count = extracted_files_count + 1
    end

    def files_from_path
      decorate(Dir[File.join(path, ARCHIVE_PATTERN)])
    end

    # decorate - sort array with files
    # As file names are unix timestamps
    # we want to keep chronological order.
    def decorate(files)
      files.sort
    end

    attr_reader :path, :saver
    attr_writer :extracted_files_count
  end
end