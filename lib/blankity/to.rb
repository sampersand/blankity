# frozen_string_literal: true
# rbs_inline: enabled

module Blankity
  module To
    module_function

    # @rbs (_ToI, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToI] -> void } -> ToI
    def i(value, ...) = ToI.new(value.to_i, ...)

    # @rbs (int, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToInt] -> void } -> ToInt
    def int(value, ...) = ToInt.new(value.to_int, ...)

    # @rbs (_ToS, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToS] -> void } -> ToS
    def s(value, ...) = ToS.new(value.to_s, ...)

    # @rbs (string, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToStr] -> void } -> ToStr
    def str(value, ...) = ToStr.new(value.to_str, ...)

    # Create a type which _only_ responds to `.to_a`. See `to_helper` for details.
    #
    # This supports `a(1, 2, 3)` as a convenient shorthand for `a([1, 2, 3])`. To
    # create a `.to_a` that returns an array containing just an array, just use `a([array])`.
    #
    # @rbs [T] (_ToA[T], ?methods: Array[interned], ?hash: bool) ?{ () [self: ToA[T]] -> void } -> ToA[T]
    #    | [T] (*T, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToA[T]] -> void } -> ToA[T]
    def a(*elements, **, &)
      if elements.length == 1 && defined?(elements[0].to_a)
        elements = (__any__ = elements[0]).to_a
      end

      ToA.new(elements, **, &)
    end

    # Create a type which _only_ responds to `.to_ary`. See `to_helper` for details.
    #
    # This supports `ary(1, 2, 3)` as a convenient shorthand for `ary([1, 2, 3])`. To
    # create a `.to_ary` that returns an array containing just an array, use `ary([array])`.
    #
    # @rbs [T] (array[T], ?methods: Array[interned], ?hash: bool) ?{ () [self: ToAry[T]] -> void } -> ToAry[T]
    #    | [T] (*T, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToAry[T]] -> void } -> ToAry[T]
    def ary(*elements, **, &)
      if elements.length == 1 && defined?(elements[0].to_ary)
        elements = (__any__ = elements[0]).to_ary
      end

      ToAry.new(elements, **, &)
    end

    # Create a type which _only_ responds to `.to_h`. See `to_helper` for details.
    #
    # This supports passing in key/values directly via `h('a' => 'b')` as a convenient
    # shorthand for `h({'a' => 'b'})`, but the shorthand version doesn't allow you
    # to supply keyowrd arguments that `to_helper` expects. Use `h({'a' => 'b'}, ...)` for that.
    #
    # @rbs [K, V] (_ToH[K, V], ?methods: Array[interned], ?hash: bool) ?{ () [self: ToH[K, V]] -> void } -> ToH[K, V]
    #    | [K, V] (**V) ?{ () [self: ToH[K, V]] -> void } -> ToH[K, V]
    def h(hash = nohash=true, **, &)
      if nohash
        ToH.new({**}, &)
      else
        ToH.new(hash.to_h, **, &)
      end
    end

    # Create a type which _only_ responds to `.to_hash`. See `to_helper` for details.
    #
    # This supports passing in key/values directly via `h('a' => 'b')` as a convenient
    # shorthand for `h({'a' => 'b'})`, but the shorthand version doesn't allow you
    # to supply keyowrd arguments that `to_helper` expects. Use `h({'a' => 'b'}, ...)` for that.
    #
    # @rbs [K, V] (hash[K, V], ?methods: Array[interned], ?hash: bool) ?{ () [self: ToHash[K, V]] -> void } -> ToHash[K, V]
    #    | [K, V] (**V) ?{ () [self: ToHash[K, V]] -> void } -> ToHash[K, V]
    def hash(hash = nohash=true, **, &)
      if nohash
        ToHash.new({**}, &)
      else
        ToHash.new((__any__ = hash).to_hash, **, &)
      end
    end

    # @rbs (_ToSym, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToSym] -> void } -> ToSym
    def sym(value, ...) = ToSym.new(value.to_sym, ...)

    # @rbs (_ToR, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToR] -> void } -> ToR
    def r(value, ...) = ToR.new(value.to_r, ...)

    # @rbs (_ToC, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToC] -> void } -> ToC
    def c(value, ...) = ToC.new(value.to_c, ...)

    # @rbs (float, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToF] -> void } -> ToF
    def f(value, ...) = ToF.new(value.to_f, ...)

    # @rbs (Regexp::_ToRegexp, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToRegexp] -> void } -> ToRegexp
    def regexp(value, ...) = ToRegexp.new(value.to_regexp, ...)

    # @rbs (path, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToPath] -> void } -> ToPath
    def path(value, ...)
      ToPath.new(defined?(value.to_path) ? value.to_path : String(value), ...)
    end

    # @rbs (io, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToIO] -> void } -> ToIO
    def io(value, ...) = ToIO.new(value.to_io, ...)

    # @rbs (_ToProc, ?methods: Array[interned], ?hash: bool) ?{ () [self: ToProc] -> void } -> ToProc
    def proc(proc = noproc=true, **, &block)
      if noproc
        unless block_given?
          raise ArgumentError, 'if an explicit proc is omitted, a block must be passed'
        end

        ToProc.new(__any__ = block, **)
      else
        ToProc.new(proc.to_proc, **, &block)
      end
    end

    # Create a type which _only_ responds to `.begin`, `.end`, and `.exclude_end?`
    # (the methods required to be considered a "custom range," eg for `Array#[]`.) See
    # `to_helper` for details.
    #
    # @rbs [T] (T?, T?, ?bool, ?methods: Array[interned], ?hash: bool) ?{ () [self: Range[T]] -> void } -> Range[T]
    def range(begin_, end_, exclude_end = false, ...)
      Range.new(begin_, end_, exclude_end, ...)
    end
  end
end
