# frozen_string_literal: true

module Inputs
  module User
    class OtpAction < Inputs::Base
      argument :enable, Boolean, required: false
      argument :code, String, required: false
    end
  end
end
