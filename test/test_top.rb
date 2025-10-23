# frozen_string_literal: true

require 'test_helper'

class TestBlankity_Top < Minitest::Test
  def test_it_has_no_instance_methods
    assert_empty Blankity::Top.public_instance_methods
    assert_empty Blankity::Top.private_instance_methods
    assert_empty Blankity::Top.protected_instance_methods
  end
end
