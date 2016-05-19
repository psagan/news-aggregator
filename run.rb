require_relative File.join('simple_autoloader')

# initial configuration
host = 'http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/'
destination_directory = 'tmp'
redis_connection = {}
number_of_threads = ARGV[0]

# make temporary dir if doesn't exist
Dir.exist?(destination_directory) || Dir.mkdir(destination_directory, 0755)

# instance of redis class to communicate with redis
redis = Redis.new(redis_connection)

# Factory Method Pattern to create downloader
downloader_factory = Downloader::Factory.new(
    host: host,
    destination: destination_directory,
    communication_class: Communication::NetHttp,
    number_of_threads: number_of_threads
)
downloader = downloader_factory.create

# instantiate extractor
extractor = Extractor::Zip.new(
    path: destination_directory,
    saver: Storage::Redis::DocumentContainer.new(redis),
    cleaner: Cleaner::Filesystem.new
)

# I use dependency injection and aggregation (of external objects) approach here
aggregator = Aggregator.new(
    online_files: OnlineFiles::ListOfZipFiles.new(Communication::NetHttp.new(host)),
    archives_container: Storage::Redis::ArchivesContainer.new(redis),
    downloader: downloader,
    extractor: extractor
)

# run main method of aggregator - run all processes
aggregator.run

# show summary
puts " SUMMARY ".center(21, '*')
puts sprintf("%d archives downloaded", downloader.downloaded_files_count)
puts sprintf("%d documents imported", extractor.extracted_files_count)
