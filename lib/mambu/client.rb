module Mambu
  class Client < ApiModel
    extend Mambu::Finders
    extend Mambu::Helpers

    def self.create_client(connection, data)
      response = connection.post("#{endpoint(connection)}",
        camelize_hash(data)
      )
      handle_error(response)
      new(response.body)
    end
  end
end
