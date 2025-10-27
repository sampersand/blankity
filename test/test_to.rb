require 'test_helper'

class TestBlankity_To < Minitest::Test
  def test_included
    old_verbose = $VERBOSE

    $VERBOSE = true
    out, err = capture_io do
      Class.new { include Blankity::To }
    end
    assert_predicate out, :empty?
    assert_match 'including Blankity::To overwrites Kernel#proc and Kernel#hash', err

    $VERBOSE = false
    out, err = capture_io do
      Class.new { include Blankity::To }
    end
    assert_predicate out, :empty?
    assert_predicate err, :empty?

    $VERBOSE = nil
    out, err = capture_io do
      Class.new { include Blankity::To }
    end
    assert_predicate out, :empty?
    assert_predicate err, :empty?
  ensure
    $VERBOSE = old_verbose
  end

  def test_extended
    old_verbose = $VERBOSE

    $VERBOSE = true
    out, err = capture_io do
      Class.new { extend Blankity::To }
    end
    assert_predicate out, :empty?
    assert_match 'extending Blankity::To overwrites Kernel#proc and Kernel#hash', err

    $VERBOSE = false
    out, err = capture_io do
      Class.new { extend Blankity::To }
    end
    assert_predicate out, :empty?
    assert_predicate err, :empty?

    $VERBOSE = nil
    out, err = capture_io do
      Class.new { extend Blankity::To }
    end
    assert_predicate out, :empty?
    assert_predicate err, :empty?
  ensure
    $VERBOSE = old_verbose
  end

  def test_prepended
    old_verbose = $VERBOSE

    $VERBOSE = true
    out, err = capture_io do
      Class.new { prepend Blankity::To }
    end
    assert_predicate out, :empty?
    assert_match 'prepending Blankity::To overwrites Kernel#proc and Kernel#hash', err

    $VERBOSE = false
    out, err = capture_io do
      Class.new { prepend Blankity::To }
    end
    assert_predicate out, :empty?
    assert_predicate err, :empty?

    $VERBOSE = nil
    out, err = capture_io do
      Class.new { prepend Blankity::To }
    end
    assert_predicate out, :empty?
    assert_predicate err, :empty?
  ensure
    $VERBOSE = old_verbose
  end

  def assert_to_method_works(method, cls, expected)
    instance = Blankity::To.public_send(method, expected, methods: %i[instance_of?]) {
      def hello = 10
    }

    # Make sure it returns a `cls`
    assert_instance_of cls, instance

    # Make sure you can pass procs
    assert_equal 10, instance.hello

    # Make sure the method actually works
    assert_equal expected, instance.__send__(:"to_#{method}")

    # Make sure you can feed it into itself
    assert_equal expected, Blankity::To.public_send(method, instance).__send__(:"to_#{method}")
  end

  def test_i
    assert_to_method_works :i, Blankity::ToI, 1
  end

  def test_int
    assert_to_method_works :int, Blankity::ToInt, 1
  end

  def test_s
    assert_to_method_works :s, Blankity::ToS, 'str'
  end

  def test_str
    assert_to_method_works :str, Blankity::ToStr, 'str'
  end

  def test_a
    instance = Blankity::To.a(1, 2, 3, methods: %i[instance_of?]) { def hello = 10 }

    # Make sure it returns a `cls`
    assert_instance_of Blankity::ToA, instance

    # Make sure you can pass procs
    assert_equal 10, instance.hello

    # Make sure the method actually works
    assert_equal [1, 2, 3], instance.to_a

    # Make sure you can feed it into itself
    assert_equal [1, 2, 3], Blankity::To.a(*instance).to_a
  end

  def test_ary
    instance = Blankity::To.ary(1, 2, 3, methods: %i[instance_of?]) { def hello = 10 }

    # Make sure it returns a `cls`
    assert_instance_of Blankity::ToAry, instance

    # Make sure you can pass procs
    assert_equal 10, instance.hello

    # Make sure the method actually works
    assert_equal [1, 2, 3], instance.to_ary

    # Make sure you can feed it into itself
    assert_equal [1, 2, 3], Blankity::To.ary(*instance.to_ary).to_ary
  end

  def test_h
    instance = Blankity::To.h({ 'a' => 'b' }, methods: %i[instance_of?]) { def hello = 10 }

    # Make sure it returns a `cls`
    assert_instance_of Blankity::ToH, instance

    # Make sure you can pass procs
    assert_equal 10, instance.hello

    # Make sure the method actually works
    assert_equal Hash['a' => 'b'], instance.to_h

    # Make sure you can feed it into itself
    assert_equal Hash['a' => 'b'], Blankity::To.h(instance.to_h).to_h

    # Make sure the non-method one works too
    instance2 = Blankity::To.h('c' => 'd', methods: %i[instance_of?]) { def hello = 10 }
    assert_equal 10, instance2.hello
    assert_equal Hash['c' => 'd', methods: %i[instance_of?]], instance2.to_h
    assert_equal Hash['c' => 'd', methods: %i[instance_of?]], Blankity::To.h(instance2.to_h).to_h
  end


  def test_hash
    instance = Blankity::To.hash({ 'a' => 'b' }, methods: %i[instance_of?]) { def hello = 10 }

    # Make sure it returns a `cls`
    assert_instance_of Blankity::ToHash, instance

    # Make sure you can pass procs
    assert_equal 10, instance.hello

    # Make sure the method actually works
    assert_equal Hash['a' => 'b'], instance.to_hash

    # Make sure you can feed it into itself
    assert_equal Hash['a' => 'b'], Blankity::To.hash(instance.to_hash).to_hash

    # Make sure the non-method one works too
    instance2 = Blankity::To.hash('c' => 'd', methods: %i[instance_of?]) { def hello = 10 }
    assert_equal 10, instance2.hello
    assert_equal Hash['c' => 'd', methods: %i[instance_of?]], instance2.to_hash
    assert_equal Hash['c' => 'd', methods: %i[instance_of?]], Blankity::To.hash(instance2.to_hash).to_hash
  end

  def test_sym
    assert_to_method_works :sym, Blankity::ToSym, :symbol
  end

  def test_r
    assert_to_method_works :r, Blankity::ToR, 1r
  end

  def test_c
    assert_to_method_works :c, Blankity::ToC, 1i
  end

  def test_f
    assert_to_method_works :f, Blankity::ToF, 1.0
  end

  def test_regexp
    assert_to_method_works :regexp, Blankity::ToRegexp, /regex/
  end

  def test_path
    assert_to_method_works :path, Blankity::ToPath, 'path'
  end

  def test_io
    assert_to_method_works :io, Blankity::ToIO, $stdout
  end

  def test_proc
    assert_to_method_works :proc, Blankity::ToProc, proc { 3 }

    # Make sure you can pass a block
    instance = Blankity::To.proc(methods: %i[instance_of?]) { 3 }
    assert_instance_of Blankity::ToProc, instance
    assert_equal 3, instance.to_proc.call
    assert_equal 3, Blankity::To.proc(instance).to_proc.call
  end

  def test_range
    instance = Blankity::To.range(10, 20, true, methods: %i[instance_of?]) {
      def hello = 10
    }

    # Make sure it returns a `cls`
    assert_instance_of Blankity::Range, instance

    # Make sure you can pass procs
    assert_equal 10, instance.hello

    # Make sure the method actually works
    assert_equal 10, instance.begin
    assert_equal 20, instance.end
    assert_equal true, instance.exclude_end?
  end
end
