require_relative File.join('simple_autoloader')

# initial configuration
host = 'http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/'
destination_directory = 'tmp'
redis_connection = {}
number_of_threads = ARGV[0]

# make temporary dir if doesn't exist
Dir.exist?(destination_directory) || Dir.mkdir(destination_directory, 0755)

# Factory Method Pattern to create downloader
downloader_factory = Downloader::Factory.new(
    host: host,
    destination: destination_directory,
    communication_class: Communication::NetHttp,
    number_of_threads: number_of_threads
)

# instance of redis class to communicate with redis
redis = Redis.new(redis_connection)

# I use dependency injection and aggregation (of external objects) approach here
aggregator = Aggregator.new(
    online_files: OnlineFiles::ListOfZipFiles.new(Communication::NetHttp.new(host)),
    archives_container: Storage::Redis::ArchivesContainer.new(redis),
    downloader: downloader_factory.create,
    extractor: Extractor::Zip.new(
        path: destination_directory,
        saver: Storage::Redis::DocumentContainer.new(redis),
        cleaner: Cleaner::Filesystem.new
    )
)

# run main method of aggregator - run all processes
aggregator.run

# show summary
summary = aggregator.summary
puts " SUMMARY ".center(21, '*')
puts sprintf("%s archives downloaded", summary[:downloaded_archives])
puts sprintf("%s documents imported", summary[:imported_documents])
