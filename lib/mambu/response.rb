module Mambu
  class Response
    attr_reader :http_status, :body, :faraday_response, :error_code, :error_status

    def initialize(faraday_response)
      @faraday_response = faraday_response
      @http_status = faraday_response.status
      @body = parse_body(faraday_response.body)
      return self if success?
      @error_code = @body[:return_code]
      @error_status = @body[:return_status]
    end

    def success?
      @faraday_response.success?
    end

    def error?
      !success?
    end

    def error_message
      error_status.humanize
    end

    def error
      Mambu::Error.new(error_message, error_code, error_status)
    end

    private

    def parse_body(json_body)
      convert_hash_keys(JSON.parse(json_body))
    end

    def convert_hash_keys(value)
      case value
      when Array
        value.map(&method(:convert_hash_keys))
      when Hash
        Hash[value.map { |k, v| [k.to_s.underscore.to_sym, convert_hash_keys(v)] }]
      else
        value
      end
    end
  end
end
