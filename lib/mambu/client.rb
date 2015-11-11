module Mambu
  class Client < ApiModel
    extend Mambu::Finders
    extend Mambu::Helpers

    def set_trn trn
      response = connection.patch("#{self.class.endpoint(connection)}/#{id.to_i.to_s}/custominformation/trn", {value: trn})
    end

    def self.create_client(connection, data)
      response = connection.post("#{endpoint(connection)}",
        camelize_hash(data)
      )
      handle_error(response)
      new(response.body)
    end
  end
end
