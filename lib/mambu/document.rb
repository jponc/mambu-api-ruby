module Mambu
  class Document < ApiModel
    extend Mambu::Finders
    extend Mambu::Helpers

    def self.create_attachment(connection, data)
      response = connection.post("#{endpoint(connection)}",
        camelize_hash(data)
      )
      handle_error(response)
      new(response.body)
    end
  end
end
