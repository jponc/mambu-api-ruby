module Mambu
  class ApiModel
    def initialize(data)
      data.each do |method_name, value|
        self.class.send(:attr_accessor, method_name) unless self.class.method_defined?(method_name)
        send("#{method_name}=", value)
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

    def self.api_uri
      name.demodulize.downcase.pluralize
    end
  end
end
