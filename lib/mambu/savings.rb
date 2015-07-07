module Mambu
  class Savings < ApiModel
    extend Mambu::Helpers

    def self.create_deposit(account_id, connection, data)
      response = connection.post(
        "#{endpoint(connection)}/#{account_id}/transactions",
        camelize_hash(data)
      )
      handle_error(response)
      new(response.body)
    end
  end
end
