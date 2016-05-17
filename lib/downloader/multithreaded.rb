require_relative 'base'

module Downloader
  class Multithreaded < Base

    def initialize(params)
      super
      @number_of_threads = params.fetch(:number_of_threads)
    end

    def download_all(file_names)
      queue = Queue.new
      file_names.map { |f| queue << f }

      threads = number_of_threads.times.map do
        Thread.new do
          while !queue.empty? && filename = queue.pop
            download_one(filename)
          end
        end
      end

      threads.each(&:join)
    end

    private

    def number_of_threads
      @number_of_threads.to_i
    end

  end
end