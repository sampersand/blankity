# frozen_string_literal: true

require 'test_helper'
__END__
class TestBlankity_ToI < Minitest::Test
  def test_that_it_only_defines__to_i
  EXPECTED_INSTANCE_METHODS = %i[__send__ __id__ __with_Object_methods__]

  def test_that_it_has_only_three_instance_methods
    assert_equal Blankity::BlankSlate.instance_methods.sort, EXPECTED_INSTANCE_METHODS.sort
  end

  def test_that_instance_method___with_Object_methods___defines_methods
    instance = Blankity::BlankSlate.new

    # Make sure it doesn't start with `inspect`
    refute defined?(instance.inspect)

    # Add inspect on
    return_value = instance.__with_Object_methods__(:inspect)

    # Make sure it returns `self`, and `inspect` was defined
    assert_equal instance.__id__, return_value.__id__
    assert defined?(instance.inspect)
  end

  def test_that_class_method___with_Object_methods___defines_methods
    subclass = Class.new(Blankity::BlankSlate)

    # Make sure it doesn't start with `inspect`
    refute_includes subclass.instance_methods, :inspcet

    # Add inspect on
    return_value = subclass.__with_Object_methods__(:inspect)

    # Make sure it returns `self`, and `inspect` was defined
    assert_equal subclass.__id__, return_value.__id__
    assert_includes subclass.instance_methods, :inspect
  end

  def test_that_blank_creates_a_subclass
    blank = Blankity::BlankSlate.blank
    assert ::Object.instance_method(:is_a?).bind_call blank, Blankity::BlankSlate
  end

  def test_that_blank_creates_a_subclass_and_can_take_a_block
    blank = Blankity::BlankSlate.blank { def foo = 34 }

    assert ::Object.instance_method(:is_a?).bind_call blank, Blankity::BlankSlate
    assert_equal 34, blank.foo
  end
end
