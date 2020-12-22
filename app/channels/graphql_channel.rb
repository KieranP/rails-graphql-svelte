class GraphqlChannel < ApplicationCable::Channel
  def subscribed
    @subscription_ids = []
  end

  def unsubscribed
    @subscription_ids.each { |sid|
      Schema.subscriptions.delete_subscription(sid)
    }
  end

  def execute(data)
    result = Schema.execute(**schema_options(data))

    if sub_id = result.context[:subscription_id]
      @subscription_ids << sub_id
    end

    transmit(
      result: result.to_h,
      more: result.subscription?
    )
  end

  private

  def schema_options(data)
    {
      query: data['query'],
      operation_name: data['operationName'],
      variables: ensure_hash(data['variables']),
      context: {
        current_user: current_user,
        # cookies: cookies,
        channel: self
      }
    }
  end

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
