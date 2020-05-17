class Api

    def self.get_meals(main_ingredient)
        url = "https://api.spoonacular.com/recipes/search?query=#{main_ingredient}&apiKey=2136f4985e444fff867de5a0c46fb46c"
        response = Net::HTTP.get(URI(url)) #this goes out and interacts with the api and returns data
        meals = JSON.parse(response)["results"] #iterate over the array and then make objects for that dinner meal
        meals.each do |meal_details|
            name = meal_details["title"]
            meal_id = meal_details["id"]
            Meal.new(name: name, meal_id: meal_id, main_ingredient: main_ingredient)
        end
        
        

            
        #go out to api and return that data
        #what is my endpoint - here am i trying to go to get that information
        #how do I go there and how do I get what I need
        #returns json and so how do i handle that json and turn it into meaningful data - something i can work with
        #how do i make dinner objects from that data
    end

    def self.getAnalyzedInstructions(meal)
        ##what is my endpoint
        url = "https://api.spoonacular.com/recipes/#{meal.meal_id}/analyzedInstructions?apiKey=2136f4985e444fff867de5a0c46fb46c"
        response = Net::HTTP.get(URI(url))
        analyzed_instructions = JSON.parse(response)
        return if analyzed_instructions == nil || analyzed_instructions.length == 0
        analyzed_instructions.each do |hash_instruction|
            hash_instruction["steps"].each do |hash_step|
                meal.instructions << Instruction.new(step: hash_step["step"], number: hash_step["number"], ingredients: hash_step["ingredients"].map{|hash_ingredient| meal.get_ingredient_by_name(hash_ingredient["name"])})
            end
        end
        #hoe do I got there and get what I need
        #how to I parse the response and what do I want to do from there
    end

    def self.getIngredients(meal)
    url = "https://api.spoonacular.com/recipes/#{meal.meal_id}/ingredientWidget.json?apiKey=2136f4985e444fff867de5a0c46fb46c"
    response = Net::HTTP.get(URI(url))
    ingredients = JSON.parse(response)
    meal.ingredients = ingredients["ingredients"].map{|hash_ingredient| Ingredient.new(name: hash_ingredient["name"], value: hash_ingredient["amount"]["us"]["value"], unit: hash_ingredient["amount"]["us"]["unit"])}
    end
    # service file/class. It is responsible for talking to Api - going out to it and getting my info and returning it
end
