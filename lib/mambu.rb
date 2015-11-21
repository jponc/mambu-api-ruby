require "active_support/all"
require "faraday"
require "json"
require "mambu/version"
require "mambu/finders"
require "mambu/error"
require "mambu/helpers"
require "mambu/response"
require "mambu/api_model"
require "mambu/client"
require "mambu/client_helpers"
require "mambu/document"
require "mambu/document_helpers"
require "mambu/loan"
require "mambu/loan_helpers"
require "mambu/loan_product"
require "mambu/loan_fee"
require "mambu/loan_schedule"
require "mambu/repayment"
require "mambu/savings"

require "mambu/connection"

begin
  require "pry"
rescue LoadError
end


module Mambu
  # Your code goes here...
end
