# frozen_string_literal: true

class Blankity::BlankSlate < BasicObject
  # Remove every method except for `__send__` and `__id__`
  instance_methods.each do |name|
    undef_method(name) unless name == :__send__ || name == :__id__
  end

  # A helper method to also include methods that are defined on `Kernel`
  def __with_Kernel_method__(*methods)
    dsm = ::Kernel.instance_method(:define_singleton_method).bind(self)

    methods.each do |method|
      dsm.call(method, ::Kernel.instance_method(method))
    end

    self
  end

  # Same as `__with_Kernel_method__`, but adds them to subclasses. This shouldn't
  # be called on `Blankity::BlankSlate` directly, as that affects subclasses
  def self.__with_Kernel_method__(*methods)
    if ::Blankity::BlankSlate.equal?(self)
      raise ArgumentError, 'Cannot call `__with_Kernel_method__` on BlankSlate, as that will affect all blank slates'
    end

    methods.each do |method|
      define_method(method, ::Kernel.instance_method(method))
    end

    self
  end

  # Helper method to create a new `BlankSlate` with a block
  def self.blank(&block)
    ::Class.new(self, &block).new
  end
end
