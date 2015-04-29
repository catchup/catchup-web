require "test_helper"

class OmniAuthTest < ActiveSupport::TestCase
  test "`OmniAuth::Strategies::OAuth2#callback_url` is defined" do
    assert OmniAuth::Strategies::OAuth2.instance_methods.include?(:callback_url)
  end
end
