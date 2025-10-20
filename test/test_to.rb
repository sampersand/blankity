# frozen_string_literal: true

require 'test_helper'

class TestBlankity_To < Minitest::Test
  EXPECTED_INSTANCE_METHODS = %i[__send__ __id__ __with_Object_methods__]

  def assert_defined?(method, expected, value)
    assert_equal(
      ::Object.instance_method(:methods).bind_call(value).sort,
      (EXPECTED_INSTANCE_METHODS + [method]).sort
    )

    assert_equal expected, value.__send__(method)
  end

  # def i(value, ...) = to_helper(:to_i, value.to_i, ...)

  def test_that_it_defines_i
    assert_defined? :to_i, 3, Blankity::To.i(3)
    assert_defined? :to_i, 3, Blankity::To.i(Blankity::To.i(3))
  end
end
