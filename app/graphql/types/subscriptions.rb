# frozen_string_literal: true

module Types
  class Subscriptions < Object
    field :user_updated, subscription: ::Subscriptions::Users::Updated

    field :post_updated, subscription: ::Subscriptions::Posts::Updated
  end
end
