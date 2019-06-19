require 'minitest/autorun'
require_relative 'my_logger'

class MyLoggerHistoryTest < MiniTest::Test
  def test_history_for_single_log
    MyLogger.instance.info 'foo'
    assert_equal %w(foo), MyLogger.instance.history
  end

  def test_history_for_multiple_logs
    MyLogger.instance.info 'foo'
    MyLogger.instance.debug 'bar'
    MyLogger.instance.error 'buzz'
    assert_equal %w(foo bar buzz), MyLogger.instance.history
  end

  def teardown
    MyLogger.instance.clear_history
  end
end
