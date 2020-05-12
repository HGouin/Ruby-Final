class Dinner
    #responsible for making dinners.
    attr_accessor :name, :dinner_id, :main_ingredient, :analyzed_instructions, :cook_time, :ingredients

    @@all = []

    def initialize(name:, dinner_id:, main_ingredient:)
        @name = name
        @dinner_id = dinner_id
        @main_ingredient = main_ingredient
        @ingredients = []
        @analyzed_instructions = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.clear
        @@all.clear
    end

    def self.select_by_main_ingredient(main_ingredient)
        self.all.select{|dinner| dinner.main_ingredient == main_ingredient}
    end

    def print_ingredients
        @ingredients.each.with_index(1) {|ingredient, i| puts "#{i}. #{ingredient["amount"]["us"]["value"]} #{ingredient["amount"]["us"]["unit"]} #{ingredient["name"]}"}
    end
   
end