class Meal
    #responsible for making meals
    attr_accessor :name, :meal_id, :main_ingredient, :instructions, :ingredients

    @@all = []

    def initialize(name:, meal_id:, main_ingredient:)
        @name = name
        @meal_id = meal_id
        @main_ingredient = main_ingredient
        @ingredients = []
        @instructions = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.clear
        @@all.clear
    end

    def self.select_by_main_ingredient(main_ingredient)
        self.all.select{|meal| meal.main_ingredient == main_ingredient}
    end

    def print_ingredients
        @ingredients.each.with_index(1) {|ingredient, i| puts "#{i}. #{ingredient.value} #{ingredient.unit} #{ingredient.name}"}
    end

    def print_instruction(step)
        current_instruction = @instructions[step]
        puts "#{step+1}. #{current_instruction.step}"
        current_ingredients = current_instruction.ingredients.select{|ingredient| ingredient != nil} if current_instruction.ingredients != nil
        if current_ingredients != nil && current_ingredients.length > 0
            puts ""
            puts "Ingredients for this step"
            current_ingredients.each.with_index(1) {|ingredient, i| puts "#{i}. #{ingredient.value} #{ingredient.unit} #{ingredient.name}"}
        end

    end

    def get_ingredient_by_name(ingredient_name)
        @ingredients.find{|ingredient| ingredient.name == ingredient_name}
    end
   
end