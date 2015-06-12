module Mambu
  class ApiModel
    def initialize(data)
      data.each do |key, value|
        method_name = key.to_s.underscore
        self.class.send(:attr_accessor, method_name) unless self.class.method_defined?(method_name)
        send("#{key.underscore}=", value)
      end
    end

    def self.find(id, client)
      puts "#{endpoint(client)}/#{id}"
      response = client.connection.get("#{endpoint(client)}/#{id}")
      data = JSON.parse(response.body)
      new(data)
    end

    def self.find_all(client)
      response = client.connection.get(endpoint(client))
      data_array = JSON.parse(response.body)
      data_array.map { |data| new(data) }
    end

    def self.endpoint(client)
      "#{client.api_url}/#{api_uri}"
    end
  end
end