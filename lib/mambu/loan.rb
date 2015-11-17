module Mambu
  class Loan < ApiModel
    extend Mambu::Finders
    extend Mambu::Helpers

    def self.create_loan(connection, data)
      response = connection.post("#{endpoint(connection)}",
        camelize_hash(data)
      )
      handle_error(response)
      new(response.body)
    end
  end
end
