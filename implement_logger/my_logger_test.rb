require 'minitest/autorun'
require_relative 'my_logger'

class MyLoggerTest < MiniTest::Test
  def test_new_is_private
    assert_raises(NoMethodError) { MyLogger.new }
  end

  def test_logger_instance_is_only_once
    2.times do
      MyLogger.instance
    end
    assert_equal 1, ObjectSpace.each_object(MyLogger){}
  end

  # `assert_output` has two arguments and one block.
  # The first argument is a STDOUT, the second is STDERR.
  # It executes a block and checks the STDOUT and STDERR with args.
  def test_info_prints_to_stdout
    assert_output('INFO: foo') { MyLogger.instance.info 'foo' }
  end

  def test_debug_prints_to_stdout
    assert_output('DEBUG: foo') { MyLogger.instance.debug 'foo' }
  end

  def test_error_prints_to_stdout
    assert_output('', 'ERROR: foo') { MyLogger.instance.error 'foo' }
  end
end
