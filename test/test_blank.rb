# frozen_string_literal: true

require 'test_helper'

class TestBlankity_Top < Minitest::Test
  def test_that_it_doesnt_undef_private_methods
    assert_equal BasicObject.private_instance_methods, Blankity::Blank.private_instance_methods
  end

  def test_that_it_only_has_underscore_methods
    # Ensure that only `__` methods are defined
    # NB: `instance_methods` is both protected and public
    Blankity::Blank.instance_methods.each do |method|
      assert_match(/\A__.*__\z/, method)
    end

    # In particular, make sure both `__id__` and `__send__` are defined
    blank = Blankity::Blank.new

    blank.__id__
    pass

    blank.__send__(:__id__)
    pass
  end

  def assert_singleton_methods(methods, instance)
    assert_equal(
      methods.to_set,
      Object.instance_method(:singleton_methods).bind_call(instance).to_set
    )
  end

  def test_initialize_with_argouments
    blank = Blankity::Blank.new

    # Make sure `.new` doesn't define any new instance methods
    assert_singleton_methods [], blank

    # Make sure it returns a `Blankity::Blank`
    assert Object.instance_method(:instance_of?).bind_call(blank, Blankity::Blank)
  end

  def test_initialize_with_methods
    blank = Blankity::Blank.new methods: %i[inspect ==]

    # Make sure we can use the methods
    assert_equal blank, blank

    # Make sure `blank.inspect` works too
    blank.inspect
    pass

    # Make sure methods are there
    assert_singleton_methods %i[== inspect], blank
  end

  def test_initialize_with_hash
    blank = Blankity::Blank.new(hash: true)

    # Make sure it only got `eql?` and `hash`
    assert_singleton_methods %i[eql? hash], blank

    # Make sure `.eql?` and `.hash` do what's expected
    assert_operator blank, :eql?, blank
    assert_instance_of Integer, blank.hash
  end

  def test_initialize_with_methods_and_hash
    # Make sure you can also supply it in `methods` `eql?` and `hash`
    assert_singleton_methods(
      %i[eql? hash inspect],
      Blankity::Blank.new(methods: %i[inspect eql?], hash: true)
    )
  end

  def test_initialize_with_block
    blank = Blankity::Blank.new { def foo = 34 }

    assert_equal 34, blank.foo
    assert_singleton_methods %i[foo], blank
  end

  def test_initialize_with_block_is_run_after_methods
    # Make sure that the methods are assigned first, so they can be used in
    # the block
    cls = nil
    Blankity::Blank.new(methods: %i[class]) { cls = self.class }
    assert_equal Blankity::Blank, cls
  end

  def test___define_singleton_method__
    blank = Blankity::Blank.new

    blank.__define_singleton_method__(:hello, proc { 'world' })
    assert_equal 'world', blank.hello

    blank.__define_singleton_method__(:hola) { hello + '!' }
    assert_equal 'world!', blank.hola
  end

  def test___instance_exec__
    blank = Blankity::Blank.new { def exclaim = '!' }

    result = blank.__instance_exec__(:hello, where: 'world') { |greeting, where:| "#{greeting}, #{where}#{self.exclaim}" }
    assert_equal 'hello, world!', result
  end
end
