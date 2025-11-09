# frozen_string_literal: true
# rbs_inline: enabled

module Blankity
  # An "emptier" class than {BasicObject}, which +undef+ines nearly all instance methods.
  #
  # Not _all_ methods are undefined (see {Top} for a class which does):
  #
  # - Methods which match +/\\A__.*__\\z/+ are not removed. Traditionally, these methods are expected
  #   to always be present (and +undef+ing them warns you!). Ruby has two of these: +__send__+
  #   and +__id__+
  # - Private methods are not undefined, as each one of them is expected to be present (most of them
  #   are hooks, eg +singleton_method_added+), and aren't easily accessible from external classes.
  #
  # To make using +Blank+ easier, its constructor allows you to pass a +methods:+ keyword argument,
  # which will define singleton methods based on {Object}.
  class Blank < BasicObject
    # Define top-level methods that are annoying to not have present.

    # @rbs!
    #   def __define_singleton_method__: (interned name, Method | UnboundMethod | Proc method) -> Symbol
    #                                  | (interned name) { (?) [self: self] -> untyped } -> Symbol
    #   def __instance_exec__: [T] (*untyped, **untyped) { (?) [self: self] -> T } -> T
    define_method :__define_singleton_method__, ::Kernel.instance_method(:define_singleton_method)
    alias_method :__instance_exec__, :instance_exec # Use `alias_method` instead of `alias` so rbs-inline won't pick it up

    # Remove every other public and protected method that we inherit, except for `__xyz__` methods
    instance_methods.each do |name|
      undef_method(name) unless name.match?(/\A__.*__\z/)
    end

    # Creates a new {BlankValue}, and defining singleton methods depending on the parameters
    #
    # @param methods [Array[interned]] a list of {Object} methods to define on +self+.
    # @param hash [bool] convenience argument, adds +hash+ and +eql?+ to +methods+ so the resulting
    #                    type can be used as a key in +Hash+es
    # @yield [] if a block is given, runs it via +__instance_exec__+.
    #
    # === Example
    #   # Make a empty instance
    #   Blankity::Blank.new
    #
    #   # Include `Object#inspect`, so we can print with `p`
    #   p Blankity::Blank.new(methods: %i[inspect])
    #
    #   # Define a singleton method
    #   p Blankity::Blank.new{ def cool?(other) = other == 3 }.cool?(3) #=> true
    #
    # @rbs (?methods: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(methods: [], hash: false, &block)
      # If `hash` is supplied, then add `hash` and `eql?` to the list of methods to define
      methods |= %i[hash eql?] if hash

      # Define any object methods requested by the end-user
      methods.each do |method|
        __define_singleton_method__(method, ::Object.instance_method(method).bind(self))
      end

      # If a block's provided, then `instance_exec`
      __instance_exec__(&__any__ = block) if block
    end
  end

  # Shorthand constructor {Blankity::Blank}.
  #
  # @rbs (?methods: Array[interned], ?hash: bool) ?{ () [self: Blank] -> void } -> Blank
  def self.blank(...) = Blank.new(...)
end
