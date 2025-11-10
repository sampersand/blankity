# frozen_string_literal: true

require 'test_helper'

class TestBlankity_Classes < Minitest::Test
  def test_value_class
    # Make sure it inherits from Blank, and includes no modules
    assert_equal Blankity::Blank, Blankity::Value.superclass
    assert_empty Blankity::Value.included_modules
    assert_equal %i[__value__ __value__=], Blankity::Value.instance_methods(false).sort
    assert_equal %i[initialize], Blankity::Value.private_instance_methods(false)
  end

  def assert_basic_class_works(cls, to_method, expected)
    # Make sure it inherits from Blank, and includes no modules
    assert_equal Blankity::Value, cls.superclass
    assert_empty cls.included_modules

    # Make sure it defines just the method we're expecting
    assert_equal [to_method], cls.instance_methods(false)
    assert_empty cls.private_instance_methods(false)

    # Make sure you can call the method
    assert_equal expected, cls.new(expected).__send__(to_method)

    # Make sure you can pass keyword arguments
    assert_equal(
      [expected, 5],
      cls.new(expected, with: %i[then], hash: true) { def five = hash*0 + 5 }
         .then { |instance| [instance.__send__(to_method), instance.five] }
    )
  end

  def test_ToI
    assert_basic_class_works Blankity::ToI, :to_i, 12

    # Test it with a builtin method
    assert_equal 3, Integer(Blankity::ToI.new(3))
  end

  def test_ToInt
    assert_basic_class_works Blankity::ToInt, :to_int, 12

    # Test it with a builtin method
    assert_equal [4, 4, 4], [4] * Blankity::ToInt.new(3)
  end

  def test_ToS
    assert_basic_class_works Blankity::ToS, :to_s, 'str'

    # Test it with a builtin method
    assert_equal '<hi>', "<#{Blankity::ToS.new('hi')}>"
  end

  def test_ToStr
    assert_basic_class_works Blankity::ToStr, :to_str, 'str'

    # Test it with a builtin method
    assert_equal 'hi world', 'hi' + Blankity::ToStr.new(' world')
  end

  def test_ToA
    assert_basic_class_works Blankity::ToA, :to_a, [1, 2]

    # Test it with a builtin method
    assert_equal [3, 4, 5], [*Blankity::ToA.new([3, 4, 5])]
  end

  def test_ToAry
    assert_basic_class_works Blankity::ToAry, :to_ary, [1, 2]

    # Test it with a builtin method
    assert_equal '3 hi', '%d %s' % Blankity::ToAry.new([3, 'hi'])
  end

  def test_ToH
    assert_basic_class_works Blankity::ToH, :to_h, { 'a' => 'b' }

    # (interestingly, there _are_ no ruby stdlib things that use `.to_h`)
  end

  def test_ToHash
    assert_basic_class_works Blankity::ToHash, :to_hash, { 'a' => 'b' }

    # Test it with a builtin method
    assert_equal '3 hi', '%<a>d %<b>s' % Blankity::ToHash.new({ a: 3, b: 'hi' })
  end

  def test_ToSym
    assert_basic_class_works Blankity::ToSym, :to_sym, :symbol

    # Test it with a builtin method
    category = Warning.categories.first or fail 'no warning categories?'
    was_enabled = Warning[category]
    out, err = capture_io do
      Warning[category] = true
      warn 'oops', category: Blankity::ToSym.new(category)
      Warning[category] = was_enabled
    end

    assert_equal '', out
    assert_equal "oops\n", err
  end

  def test_ToR
    assert_basic_class_works Blankity::ToR, :to_r, 12r

    # Test it with a builtin method
    assert_equal 2r, Rational(Blankity::ToR.new(2r))
  end

  def test_ToC
    assert_basic_class_works Blankity::ToC, :to_c, 34i

    # Test it with a builtin method
    assert_equal 3i, Complex(Blankity::ToC.new(3i))
  end

  def test_ToF
    assert_basic_class_works Blankity::ToF, :to_f, 5.6

    # Test it with a builtin method
    assert_equal 3.0, Regexp.new('x', timeout: Blankity::ToF.new(3.0)).timeout
  end

  def test_ToRegexp
    assert_basic_class_works Blankity::ToRegexp, :to_regexp, /regex/

    # Test it with a builtin method
    assert_equal %r/test/, Regexp.try_convert(Blankity::ToRegexp.new(/test/))
  end

  def test_ToPath
    assert_basic_class_works Blankity::ToPath, :to_path, 'path'

    # Test it with a builtin method
    assert File.exist? Blankity::ToPath.new(__FILE__)
  end

  def test_ToIO
    assert_basic_class_works Blankity::ToIO, :to_io, $stdout

    # Test it with a builtin method
    assert File.exist? Blankity::ToIO.new($stdout)
  end

  def test_ToProc
    assert_basic_class_works Blankity::ToProc, :to_proc, proc{}

    # Test it with a builtin method
    h = Hash.new
    h.default_proc = Blankity::ToProc.new(proc { |hash, key| key + 3 })
    assert_equal 4, h[1]
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
      cls.new(10, 20, with: %i[then], hash: true){ def five = hash*0 + 5 }
         .then { |instance| [instance.begin, instance.end, instance.exclude_end?, instance.five] }
    )
    assert_equal(
      [10, 20, true, 5],
      cls.new(10, 20, true, with: %i[then], hash: true){ def five = hash*0 + 5 }
         .then { |instance| [instance.begin, instance.end, instance.exclude_end?, instance.five] }
    )

    # Test it with a builtin method
    assert_equal %w[b c], %w[a b c d][Blankity::Range.new(1, 3, true)]
  end
end
