# frozen_string_literal: true

require 'test_helper'

class TestBlankity_Classes < Minitest::Test
  def assert_basic_class_works(cls, to_method, expected)
    # Make sure it inherits from Blank, and includes no modules
    assert_equal Blankity::Blank, cls.superclass
    assert_empty cls.included_modules

    # Make sure it defines just the method we're expecting
    assert_equal [to_method], cls.instance_methods(false)
    assert_equal %i[initialize], cls.private_instance_methods(false)

    # Make sure you can call the method
    assert_equal expected, cls.new(expected).__send__(to_method)

    # Make sure you can pass keyword arguments
    assert_equal(
      [expected, 5],
      cls.new(expected, methods: %i[then], hash: true) { def five = hash*0 + 5 }
         .then { |instance| [instance.__send__(to_method), instance.five] }
    )
  end

  def test_ToI
    assert_basic_class_works Blankity::ToI, :to_i, 12
  end

  def test_ToInt
    assert_basic_class_works Blankity::ToInt, :to_int, 12
  end

  def test_ToS
    assert_basic_class_works Blankity::ToS, :to_s, 'str'
  end

  def test_ToStr
    assert_basic_class_works Blankity::ToStr, :to_str, 'str'
  end

  def test_ToA
    assert_basic_class_works Blankity::ToA, :to_a, [1, 2]
  end

  def test_ToAry
    assert_basic_class_works Blankity::ToAry, :to_ary, [1, 2]
  end

  def test_ToH
    assert_basic_class_works Blankity::ToH, :to_h, { 'a' => 'b' }
  end

  def test_ToHash
    assert_basic_class_works Blankity::ToHash, :to_hash, { 'a' => 'b' }
  end

  def test_ToSym
    assert_basic_class_works Blankity::ToSym, :to_sym, :symbol
  end

  def test_ToR
    assert_basic_class_works Blankity::ToR, :to_r, 12r
  end

  def test_ToC
    assert_basic_class_works Blankity::ToC, :to_c, 34i
  end

  def test_ToF
    assert_basic_class_works Blankity::ToF, :to_f, 5.6
  end

  def test_ToRegexp
    assert_basic_class_works Blankity::ToRegexp, :to_regexp, /regex/
  end

  def test_ToPath
    assert_basic_class_works Blankity::ToPath, :to_path, 'path'
  end

  def test_ToIO
    assert_basic_class_works Blankity::ToIO, :to_io, $stdout
  end

  def test_ToProc
    assert_basic_class_works Blankity::ToProc, :to_proc, proc{}
  end

  def test_Range
    cls = Blankity::Range

    # Make sure it inherits from Blank, and includes no modules
    assert_equal Blankity::Blank, cls.superclass
    assert_empty cls.included_modules

    # Make sure it defines just the methods we're expecting
    assert_equal %i[begin end exclude_end?], cls.instance_methods(false)
    assert_equal %i[initialize], cls.private_instance_methods(false)

    # Make sure you can call the methods
    assert_equal 10, cls.new(10, 20).begin
    assert_equal 20, cls.new(10, 20).end
    assert_equal false, cls.new(10, 20).exclude_end?
    assert_equal true, cls.new(10, 20, true).exclude_end?

    # Make sure you can pass keyword arguments
    assert_equal(
      [10, 20, false, 5],
      cls.new(10, 20, methods: %i[then], hash: true){ def five = hash*0 + 5 }
         .then { |instance| [instance.begin, instance.end, instance.exclude_end?, instance.five] }
    )
    assert_equal(
      [10, 20, true, 5],
      cls.new(10, 20, true, methods: %i[then], hash: true){ def five = hash*0 + 5 }
         .then { |instance| [instance.begin, instance.end, instance.exclude_end?, instance.five] }
    )
  end
end
