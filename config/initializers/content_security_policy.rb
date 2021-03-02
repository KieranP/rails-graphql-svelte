# frozen_string_literal: true

Rails.application.config.content_security_policy do |policy|
  policy.default_src(:none)

  policy.img_src(:self)

  policy.style_src(*[
    :self,
    (:unsafe_inline if Rails.env.development?)
  ].compact)

  policy.script_src(*[
    :self,
    (:unsafe_inline if Rails.env.development?)
  ].compact)

  policy.connect_src(*[
    :self,
    ('ws://localhost:12321' if Rails.env.development?)
  ].compact)
end
