module Mambu
  class InsufficientCredentialsError < StandardError; end

  class Client
    def initialize(username, password, tenant)
      @username = username
      @password = password
      @tenant = tenant
      fail InsufficientCredentialsError unless valid?
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
