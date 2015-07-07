module Mambu
  module Helpers
    def handle_error(response)
      return if response.success?
      error = response.error
      if error.status == 'INTERNAL_SERVER_ERROR'
        error = Mambu::Error.new(
          'Known mambu issue. Please grant administrator permissions to api user.'
        )
      end
      fail error
    end

    def camelize_hash(options)
      Hash[options.map { |k, v| [k.to_s.camelize(:lower).to_sym, v] }]
    end
  end
end
