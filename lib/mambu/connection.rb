module Mambu
  class Connection
    include Mambu::ClientHelpers
    include Mambu::LoanHelpers
    include Mambu::DocumentHelpers

    def initialize(username, password, tenant)
      @username = username
      @password = password
      @tenant = tenant
      fail Mambu::Error, 'Insufficient credentials' unless valid?
    end

    def get(url, options = {})
      request(:get, url, options)
    end

    def post(url, options = {})
      request(:post, url, options)
    end

    def patch(url, options = {})
      request(:patch, url, options)
    end

    def request(method, url, options)
      options = options.to_json if method == :post
      Mambu::Response.new(connection.send(method, url, options))
    end

    def connection
      conn = Faraday.new
      conn.headers['Content-Type'] = 'application/json'
      conn.headers['Accept'] = 'application/json'
      conn.basic_auth(@username, @password)
      conn
    end

    def api_url
      "https://#{@tenant}.mambu.com/api"
    end

    def valid?
      @username.present? && @password.present? && @tenant.present?
    end

    def loan_product(id)
      Mambu::LoanProduct.find(id, self)
    end

    def loan_products
      Mambu::LoanProduct.find_all(self)
    end
  end
end
