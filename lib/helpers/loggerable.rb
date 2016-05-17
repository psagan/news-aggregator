# Simple module for logging purposes
module Loggerable
  private

  def info(message)
    logger.info(message)
  end

  def fatal(message)
    logger.fatal(message)
  end

  def logger
    @logger ||= ::Logger.new(STDOUT)
  end
end