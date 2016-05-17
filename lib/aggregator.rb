# This class is responsible for
# running whole process of news aggregation in #run method.
class Aggregator

  def initialize(params)
    @online_files = params.fetch(:online_files)
    @archives_container = params.fetch(:archives_container)
    @downloader = params.fetch(:downloader)
    @extractor = params.fetch(:extractor)
    @cleaner = params.fetch(:cleaner)
    @number_of_threads = params.fetch(:number_of_threads, 0)
  end

  # main method responsible for execution whole process
  def run
    # filter list of archives to extract only those which are not yet downloaded
    filtered_list_of_online_files = archives_container.filter_existing(list_of_online_files)

    # download archives which are not yet downloaded
    downloader.download_all(filtered_list_of_online_files)

    # save names of downloaded archives
    archives_container.add_all(downloader.downloaded_files)

    # extract archives directly into redis in fly (using saver strategy inside)
    extractor.extract

    # remove extracted temporary files
    cleaner.clean!
  end

  def summary
    {
        downloaded_archives: downloader.downloaded_files_count,
        imported_documents: extractor.extracted_files_count
    }
  end

  private

  def list_of_online_files
    @files ||= online_files.files
  end

  attr_reader :online_files, :archives_container, :downloader,
              :extractor, :number_of_threads, :cleaner

end

