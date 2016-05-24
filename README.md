# news-aggregator - CLI application
[![Build Status](https://travis-ci.org/psagan/news-aggregator.svg?branch=master)](https://travis-ci.org/psagan/news-aggregator) [![Code Climate](https://codeclimate.com/github/psagan/news-aggregator/badges/gpa.svg)](https://codeclimate.com/github/psagan/news-aggregator)

To run this CLI application
Please clone the repository, go to cloned directory and run bundler
```
bundle install
```
then please run the ruby script:
```
ruby run.rb [number_of_threads]
```
where **number_of_threads** is optional and if provided and greater than 1 than multithreaded downloader will be used:
```
ruby run.rb 4
```
if you want to use simple version of downloader please run as follows:
```
ruby run.rb
```  

## About code design
Application is written with Single Responsibility in mind and TRUE heuristic (Sandi Metz rules).
Code starts in **run.rb** file - which has simple configuration like host, destination_directory, redis_connection params and number of threads.

**run.rb** is responsible for knowing what to instantiate. I use Dependency Injection and aggregation approach.
In **run.rb** I inject all stuff to main execution object **"Aggregator"** which is responsible for running proper steps in **#run** method.

Every class is re-usable and can be replaced by other "duck". 
Every class has corresponding tests in spec directory.
