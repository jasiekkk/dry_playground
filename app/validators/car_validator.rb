require 'dry-validation'

class CarValidator
  CarSchema = Dry::Validation.Schema do
    CAR_MAKES = %w[Audi BMW Mercedes]
   
    optional(:make).filled(:str?, min_size?: 2, max_size?: 20, included_in?: CAR_MAKES)
    optional(:model).filled(:str?, min_size?: 2, max_size?: 20)
    optional(:year).filled(:int?, gteq?: 1920, lteq?: Date.current.year)
    optional(:engine_size).filled(:float?, gteq?: 0.6, lteq?: 8.0)
    optional(:description).filled(:str?, min_size?: 1, max_size?: 255)
  end
end
