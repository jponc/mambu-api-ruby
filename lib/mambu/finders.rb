module Mambu
  module Finders
    def find(id, connection)
      response = connection.get("#{endpoint(connection)}/#{id}")
      fail response.error unless response.success?
      new(response.body)
    end

    def find_all(connection)
      response = connection.get(endpoint(connection))
      fail response.error unless response.success?
      response.body.map { |data| new(data) }
    end
  end
end
