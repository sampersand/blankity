# frozen_string_literal: true
# rbs_inline: enabled

module Blankity
  # Convenience methods for creating new +BlankIty::ToXXX+ instances.
  #
  # Using +To+ as a mixin (via +extend+ / +include+ / +prepend+) isn't suggested, as {Kernel#proc}
  # and {Kernel#hash} will be overwritten. Attempting to do so will emit a warning if `$VERBOSE` is
  # enabled.
  module To
    # Warn when including +To+
    def self.included(mod)
      $VERBOSE and warn 'including Blankity::To overwrites Kernel#proc and Kernel#hash', uplevel: 1
    end

    # Warn when extending +To+
    def self.extended(mod)
      $VERBOSE and warn 'extending Blankity::To overwrites Kernel#proc and Kernel#hash', uplevel: 1
    end

    # Warn when prepending +To+
    def self.prepended(mod)
      $VERBOSE and warn 'prepending Blankity::To overwrites Kernel#proc and Kernel#hash', uplevel: 1
    end

    module_function

    # Convenience method to make {ToI}s from +value.to_i+
    #
    # @rbs (_ToI, ?with: Array[interned], ?hash: bool) ?{ () [self: ToI] -> void } -> ToI
    def i(value, ...) = ToI.new(value.to_i, ...)

    # Convenience method to make {ToInt}s from +value.to_int+
    #
    # @rbs (int, ?with: Array[interned], ?hash: bool) ?{ () [self: ToInt] -> void } -> ToInt
    def int(value, ...) = ToInt.new(value.to_int, ...)

    # Convenience method to make {ToS}s from +value.to_s+
    #
    # @rbs (_ToS, ?with: Array[interned], ?hash: bool) ?{ () [self: ToS] -> void } -> ToS
    def s(value, ...) = ToS.new(value.to_s, ...)

    # Convenience method to make {ToStr}s from +value.to_str+
    #
    # @rbs (string, ?with: Array[interned], ?hash: bool) ?{ () [self: ToStr] -> void } -> ToStr
    def str(value, ...) = ToStr.new(value.to_str, ...)

    # Convenience method to make {ToA}s from +elements+
    #
    # @rbs [T] (*T, ?with: Array[interned], ?hash: bool) ?{ () [self: ToA[T]] -> void } -> ToA[T]
    def a(*elements, **, &) = ToA.new(elements, **, &)

    # Convenience method to make {ToAry}s from +elements+
    #
    # @rbs [T] (*T, ?with: Array[interned], ?hash: bool) ?{ () [self: ToAry[T]] -> void } -> ToAry[T]
    def ary(*elements, **, &) = ToAry.new(elements, **, &)

    # Convenience method to make {ToH}s from +hash+
    #
    # This supports passing in key/values directly via +Blankity::To.h('a' => 'b')+ as a convenient
    # shorthand, but you can't then pass keyword arguments to {ToH}'s constructor. To do so, instead
    # pass in a Hash as a positional argument (e.g. +Blankity::To.h({ 'a' => 'b' }, ...)+)
    #
    # @rbs [K, V] (_ToH[K, V], ?with: Array[interned], ?hash: bool) ?{ () [self: ToH[K, V]] -> void } -> ToH[K, V]
    #    | [K, V] (**V) ?{ () [self: ToH[K, V]] -> void } -> ToH[K, V]
    def h(hash = nil, **, &)
      if hash
        ToH.new(hash.to_h, **, &)
      else
        ToH.new({**}, &)
      end
    end

    # Convenience method to make {ToHash}s from +hash+
    #
    # This supports passing in key/values directly via +Blankity::To.hash('a' => 'b')+ as a convenient
    # shorthand, but you can't then pass keyword arguments to {ToHash}'s constructor. To do so, instead
    # pass in a Hash as a positional argument (e.g. +Blankity::To.hash({ 'a' => 'b' }, ...)+)
    #
    # @rbs [K, V] (hash[K, V], ?with: Array[interned], ?hash: bool) ?{ () [self: ToHash[K, V]] -> void } -> ToHash[K, V]
    #    | [K, V] (**V) ?{ () [self: ToHash[K, V]] -> void } -> ToHash[K, V]
    def hash(hash = nil, **, &)
      if hash
        ToHash.new(hash.to_hash, **, &)
      else
        ToHash.new({**}, &)
      end
    end

    # Convenience method to make {ToSym}s from +value.to_sym+
    #
    # @rbs (_ToSym, ?with: Array[interned], ?hash: bool) ?{ () [self: ToSym] -> void } -> ToSym
    def sym(value, ...) = ToSym.new(value.to_sym, ...)

    # Convenience method to make {ToR}s from +value.to_r+
    #
    # @rbs (_ToR, ?with: Array[interned], ?hash: bool) ?{ () [self: ToR] -> void } -> ToR
    def r(value, ...) = ToR.new(value.to_r, ...)

    # Convenience method to make {ToC}s from +value.to_c+
    #
    # @rbs (_ToC, ?with: Array[interned], ?hash: bool) ?{ () [self: ToC] -> void } -> ToC
    def c(value, ...) = ToC.new(value.to_c, ...)

    # Convenience method to make {ToF}s from +value.to_f+
    #
    # @rbs (float, ?with: Array[interned], ?hash: bool) ?{ () [self: ToF] -> void } -> ToF
    def f(value, ...) = ToF.new(value.to_f, ...)

    # Convenience method to make {ToRegexp}s from +value.to_regexp+
    #
    # @rbs (Regexp::_ToRegexp | Regexp, ?with: Array[interned], ?hash: bool) ?{ () [self: ToRegexp] -> void } -> ToRegexp
    def regexp(value, ...) = ToRegexp.new(Regexp === value ? value : value.to_regexp, ...)

    # Convenience method to make {ToPath}s from +value.to_path+, or +Kernel#String(value)+
    # if +value+ doesn't define +#to_path+.
    #
    # @rbs (path, ?with: Array[interned], ?hash: bool) ?{ () [self: ToPath] -> void } -> ToPath
    def path(value, ...) = ToPath.new(defined?(value.to_path) ? value.to_path : String(value), ...)

    # Convenience method to make {ToIO}s from +value.to_io+
    #
    # @rbs (io, ?with: Array[interned], ?hash: bool) ?{ () [self: ToIO] -> void } -> ToIO
    def io(value, ...) = ToIO.new(value.to_io, ...)

    # Convenience method to make {ToProc}s from the supplied block, or +proc+ if no block is given.
    #
    # This supports passing blocks in directly via +Blankity::To.proc { ... }+ as a convenient
    # shorthand, but then you can't pass a block to {ToProc}'s constructor. To so do, instead pass
    # the block as a positional parameter (eg +Blankity::To.proc(proc { ... }) { ... }+)
    #
    # @rbs (_ToProc, ?with: Array[interned], ?hash: bool) -> ToProc
    #    | (?with: Array[interned], ?hash: bool) { (?) -> untyped } -> ToProc
    def self.proc(proc = nil, **, &block)
      if proc
        ToProc.new(proc.to_proc, **, &block)
      elsif !block_given?
        raise ArgumentError, 'if an explicit proc is omitted, a block must be passed'
      else
        ToProc.new(__any__ = block, **)
      end
    end

    # Convenience method to make {Range}s from the supplied arguments.
    #
    # @rbs [T] (T?, T?, ?bool, ?with: Array[interned], ?hash: bool) ?{ () [self: Range[T]] -> void } -> Range[T]
    def range(begin_, end_, exclude_end = false, ...)
      __any__ = Range.new(begin_, end_, exclude_end, ...)
    end
  end
end

