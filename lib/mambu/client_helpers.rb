module Mambu
  module ClientHelpers

    def clients
      Mambu::Client.find_all(self)
    end

    def client
      Mambu::Client
    end

    def create_client(data)
      Mambu::Client.create_client(self, data)
    end
  end
end
