module Mambu
  class ApiModel
    def initialize(data)
      data.each do |method_name, value|
        self.class.send(:attr_accessor, method_name) unless self.class.method_defined?(method_name)
        send("#{method_name}=", convert_decimal(value))
      end
    end

    def self.endpoint(connection)
      "#{connection.api_url}/#{api_uri}"
    end

    def self.api_uri
      name.demodulize.downcase.pluralize
    end

    def convert_decimal(value)
      return value unless (value.is_a? String) && (value =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/)
      value.to_d
    end
  end
end
