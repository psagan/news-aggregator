# Simple factory method pattern
module Downloader
  class Factory
    def initialize(params)
      @params = params
      @number_of_threads = params.fetch(:number_of_threads, 0)
    end

    def create
      if number_of_threads == 0 || number_of_threads.nil?
        Singlethreaded.new(params)
      else
        Multithreaded.new(params)
      end
    end

    private

    attr_reader :number_of_threads, :params
  end
end