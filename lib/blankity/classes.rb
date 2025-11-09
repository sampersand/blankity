# frozen_string_literal: true
# rbs_inline: enabled

module Blankity
  # A Class which only defines +#to_i+; it implements RBS's +_ToI+ interface.
  class ToI < Blank
    # @rbs @__value__: Integer

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Integer, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> Integer
    def to_i = @__value__
  end

  # A Class which exclusively defines +#to_int+; it implements RBS's +_ToInt+ interface.
  class ToInt < Blank
    # @rbs @__value__: Integer

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Integer, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> Integer
    def to_int = @__value__
  end

  # A Class which exclusively defines +#to_s+; it implements RBS's +_ToS+ interface.
  class ToS < Blank
    # @rbs @__value__: String

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (String, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> String
    def to_s = @__value__
  end

  # A Class which exclusively defines +#to_str+; it implements RBS's +_ToStr+ interface.
  class ToStr < Blank
    # @rbs @__value__: String

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (String, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> String
    def to_str = @__value__
  end

  # A Class which exclusively defines +#to_a+; it implements RBS's +_ToA[T]+ interface.
  #
  # @rbs generic unchecked out T -- Type of elements
  class ToA < Blank
    # @rbs @__value__: Array[T]

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Array[T], ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> Array[T]
    def to_a = @__value__
  end

  # A Class which exclusively defines +#to_ary+; it implements RBS's +_ToAry[T]+ interface.
  #
  # @rbs generic unchecked out T -- Type of elements
  class ToAry < Blank
    # @rbs @__value__: Array[T]

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Array[T], ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> Array[T]
    def to_ary = @__value__
  end

  # A Class which exclusively defines +#to_h+; it implements RBS's +_ToH[K, V]+ interface.
  #
  # @rbs generic unchecked out K -- Type of Key
  # @rbs generic unchecked out V -- Type of Value
  class ToH < Blank
    # @rbs @__value__: Hash[K, V]

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Hash[K, V], ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> Hash[K, V]
    def to_h = @__value__
  end

  # A Class which exclusively defines +#to_hash+; it implements RBS's +_ToHash[K, V]+ interface.
  #
  # @rbs generic unchecked out K -- Type of Key
  # @rbs generic unchecked out V -- Type of Value
  class ToHash < Blank
    # @rbs @__value__: Hash[K, V]

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Hash[K, V], ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> Hash[K, V]
    def to_hash = @__value__
  end

  # A Class which exclusively defines +#to_sym+; it implements RBS's +_ToSym+ interface.
  class ToSym < Blank
    # @rbs @__value__: Symbol

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Symbol, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> Symbol
    def to_sym = @__value__
  end

  # A Class which exclusively defines +#to_r+; it implements RBS's +_ToR+ interface.
  class ToR < Blank
    # @rbs @__value__: Rational

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Rational, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> Rational
    def to_r = @__value__
  end

  # A Class which exclusively defines +#to_c+; it implements RBS's +_ToC+ interface.
  class ToC < Blank
    # @rbs @__value__: Complex

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Complex, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> Complex
    def to_c = @__value__
  end

  # A Class which exclusively defines +#to_f+; it implements RBS's +_ToF+ interface.
  class ToF < Blank
    # @rbs @__value__: Float

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Float, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> Float
    def to_f = @__value__
  end

  # A Class which exclusively defines +#to_regexp+; it implements RBS's +Regexp::_ToRegexp+ interface.
  class ToRegexp < Blank
    # @rbs @__value__: Regexp

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Regexp, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> Regexp
    def to_regexp = @__value__
  end

  # A Class which exclusively defines +#to_path+; it implements RBS's +_ToPath+ interface.
  class ToPath < Blank
    # @rbs @__value__: String

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (String, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> String
    def to_path = @__value__
  end

  # A Class which exclusively defines +#to_io+; it implements RBS's +_ToIO+ interface.
  class ToIO < Blank
    # @rbs @__value__: IO

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (IO, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

    #: () -> IO
    def to_io = @__value__
  end

  # A Class which exclusively defines +#to_proc+; it implements RBS's +_ToProc+ interface.
  class ToProc < Blank
    # @rbs @__value__: Proc

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (Proc, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end

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

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (T?, T?, ?bool, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(begin_, end_, exclude_end = false, ...)
      @__begin__ = begin_
      @__end__ = end_
      @__exclude_end__ = exclude_end

      super(...)
    end

    #: () -> T?
    def begin = @__begin__

    #: () -> T?
    def end = @__end__

    #: () -> bool
    def exclude_end? = @__exclude_end__
  end
end
