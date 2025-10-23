# frozen_string_literal: true
# rbs_inline: enabled

module Blankity
  # A "blank slate" class which removes _all_ methods (from `BasicObject`) other than the "required"
  # ones of `__send__` and `__id__`.
  class Blank < BasicObject
    # Remove every method except for `__send__` and `__id__`
    instance_methods.each do |name|
      undef_method(name) unless name == :__send__ || name == :__id__
    end

    # A helper method to define some `Kernel`methods on `self`
    def __with_Object_methods__(*methods)
      dsm = ::Object.instance_method(:define_singleton_method).bind(self)

      methods.each do |method|
        dsm.call(method, ::Object.instance_method(method))
      end

      self
    end

    # Same as `__with_Object_methods__`, but adds them to subclasses. This shouldn't
    # be called on `Blankity::Blank` directly, as that affects subclasses
    def self.__with_Object_methods__(*methods)
      if ::Blankity::Blank.equal?(self)
        raise ArgumentError, 'Cannot call `__with_Object_methods__` on Blank, as that will affect all blank slates'
      end

      methods.each do |method|
        define_method(method, ::Kernel.instance_method(method))
      end

      self
    end

    # Helper method to create a new `Blank` with a block
    def self.blank(&block)
      ::Class.new(self, &block).new
    end
  end

  def self.blank(...) = Blank.blank(...)
end
