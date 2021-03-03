# frozen_string_literal: true

Rails.application.config.content_security_policy do |policy|
  allow_unsafe = (Rails.env.development? || Rails.env.test?)

  policy.default_src(:none)

  policy.img_src(:self)

  policy.style_src(*[
    :self,
    (:unsafe_inline if allow_unsafe)
  ].compact)

  policy.script_src(*[
    :self,
    (:unsafe_inline if allow_unsafe)
  ].compact)

  policy.connect_src(*[
    :self,
    ('ws://localhost:12321' if allow_unsafe)
  ].compact)
end
