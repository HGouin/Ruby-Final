class Api

    def self.get_meals(main_ingredient)
        url = "https://api.spoonacular.com/recipes/search?query=#{main_ingredient}&apiKey=#{SPOONACULAR_API_KEY}"
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

    def self.getIngredients(meal)
        url = "https://api.spoonacular.com/recipes/#{meal.meal_id}/ingredientWidget.json?apiKey=#{SPOONACULAR_API_KEY}"
        response = Net::HTTP.get(URI(url))
        ingredients = JSON.parse(response)
        meal.ingredients = ingredients["ingredients"].map{|hash_ingredient| Ingredient.new(name: hash_ingredient["name"], value: hash_ingredient["amount"]["us"]["value"], unit: hash_ingredient["amount"]["us"]["unit"])}
    end

    #depends on getIngredients being called first
    #flattens the different analyzed instructions into instructions - there are multiple analyzed instructions each with their own instructions
    #for purposes of my program I did not care about the bigger steps (prep work) - just the steps it takes to make the meal
    def self.getAnalyzedInstructions(meal)
        ##what is my endpoint
        url = "https://api.spoonacular.com/recipes/#{meal.meal_id}/analyzedInstructions?apiKey=#{SPOONACULAR_API_KEY}"
        response = Net::HTTP.get(URI(url))
        analyzed_instructions = JSON.parse(response)
        return if analyzed_instructions == nil || analyzed_instructions.length == 0
        analyzed_instructions.each do |hash_instruction|
            hash_instruction["steps"].each do |hash_step| #going through each step on each analyzed instruction
                # creating instruction objects and storing them on the meal
                # for each ingredient of this step, get the ingredient by name from the meal (ingredients already added using Api.getIngredients)
                ingredients = hash_step["ingredients"].map{|hash_ingredient| meal.get_ingredient_by_name(hash_ingredient["name"])}
                meal.instructions << Instruction.new(step: hash_step["step"], number: hash_step["number"], ingredients: ingredients)
            end
        end
        
    end

    
    # service file/class. It is responsible for talking to Api - going out to it and getting my info and returning it
end
