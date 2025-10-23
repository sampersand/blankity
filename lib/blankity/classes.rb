# frozen_string_literal: true
# rbs_inline: enabled

module Blankity
  class ToI < Blank
    #: (Integer) -> void
    def initialize(value) = @__value__ = value

    #: () -> Integer
    def to_i = @__value__
  end

  class ToInt < Blank
    #: (Integer) -> void
    def initialize(value) = @__value__ = value

    #: () -> Integer
    def to_int = @__value__
  end

  class ToS < Blank
    #: (String) -> void
    def initialize(value) = @__value__ = value

    #: () -> String
    def to_s = @__value__
  end

  class ToStr < Blank
    #: (String) -> void
    def initialize(value) = @__value__ = value

    #: () -> String
    def to_str = @__value__
  end

  # @rbs generic unchecked out T -- Type of elements
  class ToA < Blank
    #: (Array[T]) -> void
    def initialize(value) = @__value__ = value

    #: () -> Array[T]
    def to_a = @__value__
  end

  # @rbs generic unchecked out T -- Type of elements
  class ToAry < Blank
    #: (Array[T]) -> void
    def initialize(value) = @__value__ = value

    #: () -> Array[T]
    def to_ary = @__value__
  end

  # @rbs generic unchecked out K -- Type of Key
  # @rbs generic unchecked out V -- Type of Value
  class ToH < Blank
    #: (Hash[K, V]) -> void
    def initialize(value) = @__value__ = value

    #: () -> Hash[K, V]
    def to_h = @__value__
  end

  # @rbs generic unchecked out K -- Type of Key
  # @rbs generic unchecked out V -- Type of Value
  class ToHash < Blank
    #: (Hash[K, V]) -> void
    def initialize(value) = @__value__ = value

    #: () -> Hash[K, V]
    def to_hash = @__value__
  end

  class ToSym < Blank
    #: (Symbol) -> void
    def initialize(value) = @__value__ = value

    #: () -> Symbol
    def to_sym = @__value__
  end

  class ToR < Blank
    #: (Rational) -> void
    def initialize(value) = @__value__ = value

    #: () -> Rational
    def to_r = @__value__
  end

  class ToC < Blank
    #: (Complex) -> void
    def initialize(value) = @__value__ = value

    #: () -> Complex
    def to_C = @__value__
  end

  class ToF < Blank
    #: (Float) -> void
    def initialize(value) = @__value__ = value

    #: () -> Float
    def to_f = @__value__
  end

  class ToRegexp < Blank
    #: (Regexp) -> void
    def initialize(value) = @__value__ = value

    #: () -> Regexp
    def to_regexp = @__value__
  end

  class ToPath < Blank
    #: (String) -> void
    def initialize(value) = @__value__ = value

    #: () -> String
    def to_path = @__value__
  end

  class ToIO < Blank
    #: (IO) -> void
    def initialize(value) = @__value__ = value

    #: () -> IO
    def to_io = @__value__
  end

  # @rbs generic out T -- Type to iterate over
  class Range < Blank
    #: (T?, T?, ?bool) -> void
    def initialize(begin_, end_, exclude_end = false)
      @__begin__ = begin_
      @__end__ = end_
      @__exclude_end__ = exclude_end
    end

    #: () -> T?
    def begin = @__begin__

    #: () -> T?
    def end = @__end__

    #: () -> bool
    def exclude_end = @__exclude_end__
  end
end
