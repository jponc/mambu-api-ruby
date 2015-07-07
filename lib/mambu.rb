require "active_support/all"
require "faraday"
require "json"
require "mambu/version"
require "mambu/finders"
require "mambu/error"
require "mambu/helpers"
require "mambu/response"
require "mambu/connection"
require "mambu/api_model"
require "mambu/loan_product"
require "mambu/loan_fee"
require "mambu/loan_schedule"
require "mambu/repayment"
require "mambu/savings"

begin
  require "pry"
rescue LoadError
end


module Mambu
  # Your code goes here...
end
