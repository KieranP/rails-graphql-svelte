# frozen_string_literal: true

Rails.application.config.content_security_policy do |policy|
  policy.default_src(:none)

  policy.img_src(:self)

  policy.style_src(:self)

  policy.script_src(:self, :blob)

  policy.connect_src(:self)
end
