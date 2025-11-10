# frozen_string_literal: true
# rbs_inline: enabled

module Blankity
  # @rbs generic T
  class Value < Blank
    # The underlying value
    attr_reader :__value__ #: T

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (T, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(value, ...)
      @__value__ = value
      super(...)
    end
  end

  # A Class which only defines +#to_i+; it implements RBS's +_ToI+ interface.
  #
  # @rbs inherits Value[Integer]
  class ToI < Value
    alias to_i __value__
  end

  # A Class which exclusively defines +#to_int+; it implements RBS's +_ToInt+ interface.
  #
  # @rbs inherits Value[Integer]
  class ToInt < Value
    alias to_int __value__
  end

  # A Class which exclusively defines +#to_s+; it implements RBS's +_ToS+ interface.
  #
  # @rbs inherits Value[String]
  class ToS < Value
    alias to_s __value__
  end

  # A Class which exclusively defines +#to_str+; it implements RBS's +_ToStr+ interface.
  #
  # @rbs inherits Value[String]
  class ToStr < Value
    alias to_str __value__
  end

  # A Class which exclusively defines +#to_a+; it implements RBS's +_ToA[T]+ interface.
  #
  # @rbs generic unchecked out T -- Type of elements
  # @rbs inherits Value[Array[T]]
  class ToA < Value
    alias to_a __value__
  end

  # A Class which exclusively defines +#to_ary+; it implements RBS's +_ToAry[T]+ interface.
  #
  # @rbs generic unchecked out T -- Type of elements
  # @rbs inherits Value[Array[T]]
  class ToAry < Value
    alias to_ary __value__
  end

  # A Class which exclusively defines +#to_h+; it implements RBS's +_ToH[K, V]+ interface.
  #
  # @rbs generic unchecked out K -- Type of Key
  # @rbs generic unchecked out V -- Type of Value
  # @rbs inherits Value[Hash[K, V]]
  class ToH < Value
    alias to_h __value__
  end

  # A Class which exclusively defines +#to_hash+; it implements RBS's +_ToHash[K, V]+ interface.
  #
  # @rbs generic unchecked out K -- Type of Key
  # @rbs generic unchecked out V -- Type of Value
  # @rbs inherits Value[Hash[K, V]]
  class ToHash < Value
    alias to_hash __value__
  end

  # A Class which exclusively defines +#to_sym+; it implements RBS's +_ToSym+ interface.
  #
  # @rbs inherits Value[Symbol]
  class ToSym < Value
    alias to_sym __value__
  end

  # A Class which exclusively defines +#to_r+; it implements RBS's +_ToR+ interface.
  #
  # @rbs inherits Value[Rational]
  class ToR < Value
    alias to_r __value__
  end

  # A Class which exclusively defines +#to_c+; it implements RBS's +_ToC+ interface.
  #
  # @rbs inherits Value[Complex]
  class ToC < Value
    alias to_c __value__
  end

  # A Class which exclusively defines +#to_f+; it implements RBS's +_ToF+ interface.
  #
  # @rbs inherits Value[Float]
  class ToF < Value
    alias to_f __value__
  end

  # A Class which exclusively defines +#to_regexp+; it implements RBS's +Regexp::_ToRegexp+ interface.
  #
  # @rbs inherits Value[Regexp]
  class ToRegexp < Value
    alias to_regexp __value__
  end

  # A Class which exclusively defines +#to_path+; it implements RBS's +_ToPath+ interface.
  #
  # @rbs inherits Value[String]
  class ToPath < Value
    alias to_path __value__
  end

  # A Class which exclusively defines +#to_io+; it implements RBS's +_ToIO+ interface.
  #
  # @rbs inherits Value[IO]
  class ToIO < Value
    alias to_io __value__
  end

  # A Class which exclusively defines +#to_proc+; it implements RBS's +_ToProc+ interface.
  #
  # @rbs inherits Value[Proc]
  class ToProc < Value
    alias to_proc __value__
  end

  # A Class which defines `#begin`, `#end`, and `#exclude_end?`. It implements RBS's +_Range[T]+
  # interface.
  #
  # @rbs generic out T -- Type to iterate over
  class Range < Blank
    # @rbs @__begin__: T?
    # @rbs @__end__: T?
    # @rbs @__exclude_end__: bool

    # Creates a new instance; any additional arguments or block are passed to {Blank#initialize}.
    #
    # @rbs (T?, T?, ?bool, ?with: Array[interned], ?hash: bool) ?{ () [self: instance] -> void } -> void
    def initialize(begin_, end_, exclude_end = false, ...)
      @__begin__ = begin_
      @__end__ = end_
      @__exclude_end__ = exclude_end

      super(...)
    end

    # @rbs () -> T?
    def begin = @__begin__

    # @rbs () -> T?
    def end = @__end__

    # @rbs () -> bool
    def exclude_end? = @__exclude_end__
  end
end
