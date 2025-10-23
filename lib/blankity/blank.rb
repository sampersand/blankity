# frozen_string_literal: true
# rbs_inline: enabled

module Blankity
  # An "emptier" class than {BasicObject}, which +undef+ines nearly all instance methods.
  #
  # Not _all_ methods are undefined (see {AboslutelyBlank} for a class which does):
  #
  # - Methods which match +/\\A__.*__\\z/+ are not removed. Traditionally, these methods are expected
  #   to always be present (and +undef+ing them warns you!). Ruby has two of these: +__send__+
  #   and +__id__+
  # - Private methods are not undefined, as each one of them is expected to be present (most of them
  #   are hooks, eg +singleton_method_added+), and aren't easily accessible from external classes.
  #
  # To make using +Blank+ easier, it also provides the {Blank#__with_Object_methods__} method
  # to define singleton methods on instances that {Object} defines.
  class Blank < BasicObject
    # Remove every public and protected method that we inherit, except for `__xyz__` methods
    instance_methods.each do |name|
      undef_method(name) unless name.match? /\A__.*__\z/
    end

    # Declare these as constants so we don't constantly look them up.
    DEFINE_SINGLETON_METHOD = ::Object.instance_method(:define_singleton_method)
    INSTANCE_EXEC = ::Object.instance_method(:instance_exec)
    private_constant :DEFINE_SINGLETON_METHOD, :INSTANCE_EXEC

    # Helper method to create a new instances
    #
    # @param object_methods [Array[interned]] kernel methods to define on the instance.
    # @param block [Proc] if provided, executed via +instance_exec+ on the instance
    #
    # === Example
    #   # Make a empty instance
    #   Blankity::Blank.blank
    #
    #   # Include `Object#inspect`, so we can print with `p`
    #   p Blankity::Blank.blank(object_methods: %i[inspect])
    #
    #   # Define a singleton method
    #   p Blankity::Blank.blank{ def cool?(other) = other == 3 }.cool? 3 #=> true
    #
    #
    # @rbs: (?object_methods: Array[interned]) ?{ () [self: instance] -> void } -> instance
    def self.blank(object_methods: [], &block)
      instance = ::Class.new(Blank).new
      instance.__with_Object_methods__(*object_methods)
      INSTANCE_EXEC.bind_call(instance, &block) if block_given?
      instance
    end

    # A helper method to define {Object} instance methods on +self+
    #
    # @param methods [*interned] The list of instance methods from {Object} to define
    # @return [self]
    #
    # === Example
    #   # Make an empty instance
    #   blank = Blankity::Blank.blank
    #
    #   # Make sure it's printable
    #   blank.__with_Object_methods__(:inspect, :==)
    #
    #   # Now you can use them!
    #   fail unless blank == blank
    #   p blank
    #
    # @rbs: (*interned) -> self
    def __with_Object_methods__(*methods)
      methods.each do |method|
        DEFINE_SINGLETON_METHOD.bind_call(self, method, ::Object.instance_method(method))
      end

      self
    end
  end

  # Shorthand helper for {Blankity::Blank.blank}. See it for details
  #
  # @rbs: (?object_methods: Array[interned]) ?{ () [self: Blank] -> void } -> Blank
  def self.blank(...) = Blank.blank(...)
end
