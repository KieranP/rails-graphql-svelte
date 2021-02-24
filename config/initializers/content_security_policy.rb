Rails.application.config.content_security_policy do |policy|
  policy.default_src :none
  policy.img_src :self
  policy.style_src :self, (:unsafe_inline if Rails.env.development?)
  policy.script_src :self, (:unsafe_inline if Rails.env.development?)
  policy.connect_src :self, ('ws://localhost:12321' if Rails.env.development?)
end
