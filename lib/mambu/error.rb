module Mambu
  class Error < StandardError
    attr_reader :code, :status

    def initialize(message, code = nil, status = nil)
      super(message)
      @code = code
      @status = status
    end
  end
end
