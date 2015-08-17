module Mambu
  module Helpers
    def handle_error(response)
      return if response.success?
      error = response.error
      if error.status == 'INTERNAL_SERVER_ERROR'
        error = Mambu::Error.new(
          'Mambu API returned error without message.'
        )
      end
      fail error
    end

    def camelize_hash(options)
      Hash[options.map { |k, v| [k.to_s.camelize(:lower).to_sym, v] }]
    end
  end
end
