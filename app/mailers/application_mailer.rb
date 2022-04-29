# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  default from: ENV.fetch('MAILER_FROM')

  private

  def mail(**args)
    super(
      to: email_address_with_name(@recipient.email, @recipient.name),
      **args
    )
  end

  def url(path)
    # rubocop:disable Rails/OutputSafety
    [
      ENV.fetch('HOST_PROTO'),
      '://',
      ENV.fetch('HOST_NAME'),
      path
    ].join.html_safe
    # rubocop:enable Rails/OutputSafety
  end
end
