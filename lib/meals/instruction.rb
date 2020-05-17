class Instruction

    attr_reader :step, :number, :ingredients

    def initialize(step:, number:, ingredients:)
        @step = step
        @number = number
        @ingredients = ingredients
    end
end