# frozen_string_literal: true
# rbs_inline: enabled

module Blankity
  # BlankValue is a superclass of the +ToXXX+ classes, which consolidates their initialization
  # into one convenient place
  #
  # @rbs generic T -- type of @__value__
  class BlankValue < Blank
    # @rbs @__value__: T

    DEFINE_SINGLETON_METHOD = ::Kernel.instance_method(:define_singleton_method)
    private_constant :DEFINE_SINGLETON_METHOD

    # Creates a new {BlankValue}, and defining singleton methods depending on the parameters
    #
    # @param value [T] the backing value for this class
    # @param methods [Array[interned]] a list of methods to define on +self+ that will just forward
    #                                  everything to +value.<method>+
    # @param hash [bool] convenience argument, adds +hash+ and +eql?+ to +methods+ so the resulting
    #                    type can be used as a key in +Hash+es
    # @yield [] if a block is given, runs it via +instance_exec+.
    #
    # @rbs (T, ?methods: Array[interned], ?hash: bool) ?{ () [self: self] -> void } -> void
    def initialize(value, methods: [], hash: false, &block)
      @__value__ = value

      # If `hash` is supplied, then add `hash` and `eql?` to the list of methods to define
      methods |= %i[hash eql?] if hash

      methods.each do |method|
        # We can use `.method` instead of querying `Kernel` because all types that are used here
        # inherit from `Object`.
        DEFINE_SINGLETON_METHOD.bind_call(self, method, &@__value__.method(method))
      end

      instance_exec(&block) if block
    end
  end

  # A Class which exclusively defines +#to_i+; it implements RBS's +_ToI+ interface.
  #
  # @rbs inherits BlankValue[Integer]
  class ToI < BlankValue
    #: () -> Integer
    def to_i = @__value__
  end

  # A Class which exclusively defines +#to_int+; it implements RBS's +_ToInt+ interface.
  #
  # @rbs inherits BlankValue[Integer]
  class ToInt < BlankValue
    #: () -> Integer
    def to_int = @__value__
  end

  # A Class which exclusively defines +#to_s+; it implements RBS's +_ToS+ interface.
  #
  # @rbs inherits BlankValue[String]
  class ToS < BlankValue
    #: () -> String
    def to_s = @__value__
  end

  # A Class which exclusively defines +#to_str+; it implements RBS's +_ToStr+ interface.
  #
  # @rbs inherits BlankValue[String]
  class ToStr < BlankValue
    #: () -> String
    def to_str = @__value__
  end

  # A Class which exclusively defines +#to_a+; it implements RBS's +_ToA[T]+ interface.
  #
  # @rbs generic unchecked out T -- Type of elements
  # @rbs inherits BlankValue[Array[T]]
  class ToA < BlankValue
    #: () -> Array[T]
    def to_a = @__value__
  end

  # A Class which exclusively defines +#to_ary+; it implements RBS's +_ToAry[T]+ interface.
  #
  # @rbs generic unchecked out T -- Type of elements
  # @rbs inherits BlankValue[Array[T]]
  class ToAry < BlankValue
    #: () -> Array[T]
    def to_ary = @__value__
  end

  # A Class which exclusively defines +#to_h+; it implements RBS's +_ToH[K, V]+ interface.
  #
  # @rbs generic unchecked out K -- Type of Key
  # @rbs generic unchecked out V -- Type of Value
  # @rbs inherits BlankValue[Hash[K, V]]
  class ToH < BlankValue
    #: () -> Hash[K, V]
    def to_h = @__value__
  end

  # A Class which exclusively defines +#to_hash+; it implements RBS's +_ToHash[K, V]+ interface.
  #
  # @rbs generic unchecked out K -- Type of Key
  # @rbs generic unchecked out V -- Type of Value
  # @rbs inherits BlankValue[Hash[K, V]]
  class ToHash < BlankValue
    #: () -> Hash[K, V]
    def to_hash = @__value__
  end

  # A Class which exclusively defines +#to_sym+; it implements RBS's +_ToSym+ interface.
  #
  # @rbs inherits BlankValue[Symbol]
  class ToSym < BlankValue
    #: () -> Symbol
    def to_sym = @__value__
  end

  # A Class which exclusively defines +#to_r+; it implements RBS's +_ToR+ interface.
  #
  # @rbs inherits BlankValue[Rational]
  class ToR < BlankValue
    #: () -> Rational
    def to_r = @__value__
  end

  # A Class which exclusively defines +#to_c+; it implements RBS's +_ToC+ interface.
  #
  # @rbs inherits BlankValue[Complex]
  class ToC < BlankValue
    #: () -> Complex
    def to_C = @__value__
  end

  # A Class which exclusively defines +#to_f+; it implements RBS's +_ToF+ interface.
  #
  # @rbs inherits BlankValue[Float]
  class ToF < BlankValue
    #: () -> Float
    def to_f = @__value__
  end

  # A Class which exclusively defines +#to_regexp+; it implements RBS's +Regexp::_ToRegexp+ interface.
  #
  # @rbs inherits BlankValue[Regexp]
  class ToRegexp < BlankValue
    #: () -> Regexp
    def to_regexp = @__value__
  end

  # A Class which exclusively defines +#to_path+; it implements RBS's +_ToPath+ interface.
  #
  # @rbs inherits BlankValue[String]
  class ToPath < BlankValue
    #: () -> String
    def to_path = @__value__
  end

  # A Class which exclusively defines +#to_io+; it implements RBS's +_ToIO+ interface.
  #
  # @rbs inherits BlankValue[IO]
  class ToIO < BlankValue
    #: () -> IO
    def to_io = @__value__
  end

  # A Class which exclusively defines +#to_proc+; it implements RBS's +_ToProc+ interface.
  #
  # @rbs inherits BlankValue[Proc]
  class ToProc < BlankValue
    #: () -> Proc
    def to_proc = @__value__
  end

  # A Class which defines `#begin`, `#end`, and `#exclude_end?`. It implements RBS's +_Range[T]+
  # interface.
  #
  # @rbs generic out T -- Type to iterate over
  class Range < Blank
    # @rbs @begin: T?
    # @rbs @end: T?
    # @rbs @exclude_end: bool

    #: (T?, T?, ?bool) -> void
    def initialize(begin_, end_, exclude_end = false, methods: [], hash: false, &block)
      @__begin__ = begin_
      @__end__ = end_
      @__exclude_end__ = exclude_end

      # If `hash` is supplied, then add `hash` and `eql?` to the list of methods to define
      methods |= %i[hash eql?] if hash

      methods.each do |method|
        p method
        # We can use `.method` instead of querying `Kernel` because all types that are used here
        # inherit from `Object`.
        DEFINE_SINGLETON_METHOD.bind_call(self, method, &@__value__.method(method))
      end

      instance_exec(&block) if block
    end

    #: () -> T?
    def begin = @__begin__

    #: () -> T?
    def end = @__end__

    #: () -> bool
    def exclude_end? = @__exclude_end__
  end
end
