module Mambu
  class Connection
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

    def request(method, url, options)
      Mambu::Response.new(connection.send(method, url, options))
    end

    def connection
      conn = Faraday.new
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
