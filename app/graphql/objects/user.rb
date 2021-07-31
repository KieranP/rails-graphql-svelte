# frozen_string_literal: true

module Objects
  class User < Objects::Base
    field :uuid, ID, null: false

    field :email, String, null: true, policy: :update?
    field :name, String, null: false
    field :locale, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :otp_enabled, Boolean, null: true, policy: :update?
    field :otp_provisioning_url, String, null: true, policy: :update?

    association :posts, [Objects::Post], null: false
  end
end
