# frozen_string_literal: true

module Blankity
  module To
    module_function

    # Helper method to create new `BlankSlate`s. Args:
    # - `to_method`: The method to use, eg `to_i`
    # - `value`: What to return when `to_method` is called
    # - `methods`: Optional list of methods from to define, using `value`'s definition
    # - `hash`: Helper to also add `hash` and `eql?` to `methods`, so it can be used as a hash key
    # - `block`: If provided, a block to also run
    def to_helper(to_method, value, methods: [], hash: false, &block)
      # Convert the value to the expected method
      value = value.__send__(to_method)

      # If `hash` is supplied, then add `hash` and `eql?` to the list of methods to define
      methods |= %i[hash eql?] if hash

      ::Blankity.blank do
        # Always define the `to_method`
        define_method(to_method) { value }

        # For all the `methods` methods, fetch its definition from `value` and use that as the
        # definition
        methods.each do |method|
          define_method(method, &::Kernel.instance_method(:method).bind_call(value, method))
        end

        # If a block's given, execute it.
        class_exec(&block) if block
      end
    end

    # Create a type which _only_ responds to `.to_i`. See `to_helper` for details.
    def i(value, ...) = to_helper(:to_i, ...)

    # Create a type which _only_ responds to `.to_int`. See `to_helper` for details.
    def int(value, ...) = to_helper(:to_int, ...)

    # Create a type which _only_ responds to `.to_s`. See `to_helper` for details.
    def s(value, ...) = to_helper(:to_s, ...)

    # Create a type which _only_ responds to `.to_str`. See `to_helper` for details.
    def str(value, ...) = to_helper(:to_str, ...)

    # Create a type which _only_ responds to `.to_a`. See `to_helper` for details.
    #
    # This supports `a(1, 2, 3)` as a convenient shorthand for `a([1, 2, 3])`. To
    # create a `.to_a` that returns an array containing just an array, just use `a([array])`.
    def a(*array, **, &)
      if array.length == 1
        to_helper(:to_a, Array(array[0]), **, &)
      else
        to_helper(:to_a, array, **, &)
      end
    end

    # Create a type which _only_ responds to `.to_ary`. See `to_helper` for details.
    #
    # This supports `ary(1, 2, 3)` as a convenient shorthand for `ary([1, 2, 3])`. To
    # create a `.to_ary` that returns an array containing just an array, use `ary([array])`.
    def ary(*array, **, &)
      if array.length == 1
        to_helper(:to_ary, Array(array[0]), **, &)
      else
        to_helper(:to_ary, array, **, &)
      end
    end

    # Create a type which _only_ responds to `.to_h`. See `to_helper` for details.
    #
    # This supports passing in key/values directly via `h('a' => 'b')` as a convenient
    # shorthand for `h({'a' => 'b'})`, but the shorthand version doesn't allow you
    # to supply keyowrd arguments that `to_helper` expects. Use `h({'a' => 'b'}, ...)` for that.
    def h(hash = nohash=true, **, &)
      if nohash
        to_helper(:to_h, {**}, &)
      else
        to_helper(:to_h, hash, **, &)
      end
    end

    # Create a type which _only_ responds to `.to_hash`. See `to_helper` for details.
    #
    # This supports passing in key/values directly via `h('a' => 'b')` as a convenient
    # shorthand for `h({'a' => 'b'})`, but the shorthand version doesn't allow you
    # to supply keyowrd arguments that `to_helper` expects. Use `h({'a' => 'b'}, ...)` for that.
    def hash(hash = nohash=true, **, &)
      if nohash
        to_helper(:to_hash, {**}, &)
      else
        to_helper(:to_hash, hash, **, &)
      end
    end

    # Create a type which _only_ responds to `.to_sym`. See `to_helper` for details.
    def sym(...) = to_helper(:to_sym, ...)

    # Create a type which _only_ responds to `.to_r`. See `to_helper` for details.
    def r(...) = to_helper(:to_r, ...)

    # Create a type which _only_ responds to `.to_c`. See `to_helper` for details.
    def c(...) = to_helper(:to_c, ...)

    # Create a type which _only_ responds to `.to_f`. See `to_helper` for details.
    def f(...) = to_helper(:to_f, ...)

    # Create a type which _only_ responds to `.to_regexp`. See `to_helper` for details.
    def regexp(...) = to_helper(:to_regexp, ...)

    # Create a type which _only_ responds to `.to_path`. See `to_helper` for details.
    def path(value, ...) = to_helper(:to_path, defined?(value.to_path) ? value.to_path : String(value), ...)

    # Create a type which _only_ responds to `.to_io`. See `to_helper` for details.
    def io(...) = to_helper(:to_io, ...)

    # Create a type which _only_ responds to `.begin`, `.end`, and `.exclude_end?`
    # (the methods required to be considered a "custom range," eg for `Array#[]`.) See
    # `to_helper` for details.
    def range(begin_, end_, exclude_end = false, &)
      ::Blankity.blank do
        define_method(:begin) { begin_ }
        define_method(:end) { end_ }
        define_method(:exclude_end?) { exclude_end }

        class_exec(&block) if block
      end
    end
  end
end
