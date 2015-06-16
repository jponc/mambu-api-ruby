module Mambu
  class ModelNotFoundError < StandardError; end
  class EndpointNotFoundError < StandardError; end

  class ApiModel
    def initialize(data)
      data.each do |key, value|
        method_name = key
        self.class.send(:attr_accessor, method_name) unless self.class.method_defined?(method_name)
        send("#{key}=", value)
      end
    end

    def self.find(id, client)
      response = client.get("#{endpoint(client)}/#{id}")
      fail response.error unless response.success?
      new(response.body)
    end

    def self.find_all(client)
      response = client.get(endpoint(client))
      fail response.error unless response.success?
      response.body.map { |data| new(data) }
    end

    def self.endpoint(client)
      "#{client.api_url}/#{api_uri}"
    end
  end
end
