# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  default from: ENV['MAILER_FROM']

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
      ENV['HOST_PROTO'],
      '://',
      ENV['HOST_NAME'],
      path
    ].join.html_safe
    # rubocop:enable Rails/OutputSafety
  end
end
