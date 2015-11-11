module Mambu
  module ClientHelpers
    def clients
      Mambu::Client.find_all(self)
    end

    def create_client(client_attrs, custom_infos = [])
      custom_infos.map! do |key, val|
        {customFieldId: key, value: val}
      end
      data = { client: client_attrs, customInformation: custom_infos }
      Mambu::Client.create_client(self, data)
    end
  end
end
