module Blankity
  # A Class that has _no_ instance methods on it whatsoever.
  #
  # This is actually pretty difficult to use properly, as some methods (e.g. +initialize+
  # and +singleton_method_defined+) are expected by Ruby to always exist, and restrict a lot of
  # builtin functionality. (For example, without +singleton_method_defined+, you can't actually
  # define singleton methods _at all_.)
  #
  # @see Blank
  class AbsolutelyBlank < BasicObject
    # We have to disable warnings for just this block, as Ruby warns for `undef`ing some methods
    previous_warning, $-w = $-w, nil

    (instance_methods + private_instance_methods).each do |name|
      undef_method(name)
    end

    # Set warnings to what they used to be
    $-w = previous_warning
  end
end
