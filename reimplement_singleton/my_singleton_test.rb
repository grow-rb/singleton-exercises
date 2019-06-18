require 'minitest/autorun'
require_relative 'my_singleton'

class Foo
  include MySingleton
end

class Hoge
  include MySingleton
end

class MySingletonTest < MiniTest::Test
  def test_new_is_private
    assert_raises(NoMethodError) { Foo.new }
  end

  def test_clone_and_dup_raises_exception
    assert_raises(TypeError) { Foo.instance.clone }
    assert_raises(TypeError) { Foo.instance.dup }
  end

  # When we use `Foo` here, it sometimes fails due to
  # execution order. So we use `Hoge` here.
  def test_instance_is_created_when_method_is_called
    assert_equal 0, ObjectSpace.each_object(Hoge){}

    Hoge.instance
    assert_equal 1, ObjectSpace.each_object(Hoge){}
  end

  def test_two_instances_are_the_same
    instance1, instance2 = Foo.instance, Foo.instance
    assert instance1 == instance2
    assert instance1.equal?(instance2)
  end

  class Bar < Foo
  end

  def test_inheritance_works
    assert_raises(NoMethodError) { Bar.new }
    instance1, instance2 = Bar.instance, Bar.instance
    assert instance1 == instance2
    assert instance1.equal?(instance2)
  end
end
