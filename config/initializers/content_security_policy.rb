# frozen_string_literal: true

Rails.application.config.content_security_policy do |policy|
  policy.default_src(:none)

  policy.img_src(:self)

  policy.style_src(:self)

  policy.script_src(:self)

  policy.connect_src(:self)

  if Rails.env.development?
    # Allow @vite/client to hot reload changes in development
    policy.style_src(*policy.style_src, :unsafe_inline)
    policy.script_src(*policy.script_src, :unsafe_eval, "http://#{ViteRuby.config.host_with_port}")
    policy.connect_src(*policy.connect_src, "ws://#{ViteRuby.config.host_with_port}")
  end
end
