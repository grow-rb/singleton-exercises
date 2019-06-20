require 'minitest/autorun'
require_relative 'my_config'

class MyApp
  require 'forwardable'

  extend Forwardable

  def_delegators :config, :name, :author

  def configure(&blk)
    config.instance_eval(&blk)
  end

  def config
    MyConfig.instance
  end
end

class MyConfigurationTest < MiniTest::Test
  def teardown
    MyConfig.instance.reset
  end

  def test_reset
    config = MyConfig.instance
    config.name = 'name'
    assert_equal 'name', config.name
    config.reset
    assert_nil config.name
  end

  def test_configure_name
    app = MyApp.new
    app.configure do |c|
      c.name = 'foo'
    end
    assert_equal 'foo', app.name
  end

  def test_configure_multiple_values
    app = MyApp.new
    app.configure do |c|
      c.name = 'foo'
      c.author = 'John Doe'
    end
    assert_equal 'foo', app.name
    assert_equal 'John Doe', app.author
  end
end
