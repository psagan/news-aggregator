# news-aggregator
[![Build Status](https://travis-ci.org/psagan/news-aggregator.svg?branch=master)](https://travis-ci.org/psagan/news-aggregator)

To run this CLI application
Please clone the repository, go to cloned directory and run the ruby script:
```
ruby run.rb [number_of_threads]
```
where number_of_threads is optional and if provided and greater than 1 than multithreaded downloader will be used:
```
ruby run.rb 4
```
if you want to use simple version of downloader please run as follows:
```
ruby run.rb
```  