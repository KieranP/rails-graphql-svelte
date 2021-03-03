# frozen_string_literal: true

module AuthenticationHelpers
  def login(user)
    visit "/testing/login?id=#{user.id}"
    @loggedin = true
  end

  def logout
    return unless @loggedin

    visit '/testing/logout'
    @loggedin = false
  end
end

RSpec.configure do |config|
  config.after(:each) do
    logout
  end
end
