class Ingredient

    attr_reader :name, :value, :unit

    def initialize(name:, value:, unit:)
       @name = name
       @value = value
       @unit = unit
    end
end