# frozen_string_literal: true

require 'webmock/rspec'
WebMock.disable_net_connect!(
  allow_localhost: true,
  net_http_connect_on_start: true,
  allow: %w[
    chromedriver.storage.googleapis.com
    storage.googleapis.com
    googlechromelabs.github.io
    edgedl.me.gvt1.com
  ]
)
