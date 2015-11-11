module Mambu
  module ClientHelpers

    def clients
      Mambu::Client.find_all(self)
    end

    def client
      Mambu::Client
    end

    # custom_infos should be array of hashes
    # each hash must have the following keys: `customFieldID` and `value`
    def create_client(client_attrs, custom_infos = [])
      data = { client: client_attrs, customInformation: custom_infos }
      Mambu::Client.create_client(self, data)
    end
  end
end
