# frozen_string_literal: true

Rails.application.config.middleware.insert_before(0, Rack::Cors) do
  allow do
    origins ENV.fetch('HOST_NAME')

    resource '*',
      headers: :any,
      credentials: true,
      methods: %i[get post put patch delete options head]
  end
end
