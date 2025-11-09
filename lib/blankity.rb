# frozen_string_literal: true
# rbs_inline: enabled

module Blankity
  # Shorthand constructor {Blankity::Blank}.
  #
  # @rbs (?with: Array[interned], ?hash: bool) ?{ () [self: Blank] -> void } -> Blank
  def self.blank(...) = Blank.new(...)
end

require_relative 'blankity/version'
require_relative 'blankity/top'
require_relative 'blankity/blank'
require_relative 'blankity/classes'
require_relative 'blankity/to'
