class Api

    def self.get_dinners(main_ingredient)
        url = "https://api.spoonacular.com/recipes/search?query=#{main_ingredient}&apiKey=2136f4985e444fff867de5a0c46fb46c"
        response = Net::HTTP.get(URI(url)) #this goes out and interacts with the api and returns data
        dinners = JSON.parse(response)["results"] #iterate over the array and then make objects for that dinner meal
        dinners.each do |dinner_details|
            name = dinner_details["title"]
            dinner_id = dinner_details["id"]
            Dinner.new(name: name, dinner_id: dinner_id, main_ingredient: main_ingredient)
        end
        
        

            
        #go out to api and return that data
        #what is my endpoint - here am i trying to go to get that information
        #how do I go there and how do I get what I need
        #returns json and so how do i handle that json and turn it into meaningful data - something i can work with
        #how do i make dinner objects from that data
    end

    def self.getAnalyzedInstructions(dinner)
        ##what is my endpoint
        url = "https://api.spoonacular.com/recipes/#{dinner.dinner_id}/analyzedInstructions?apiKey=2136f4985e444fff867de5a0c46fb46c"
        response = Net::HTTP.get(URI(url))
        analyzed_instructions = JSON.parse(response)
        return if analyzed_instructions == nil || analyzed_instructions.length == 0
        dinner.analyzed_instructions = analyzed_instructions[0]["steps"]
        #hoe do I got there and get what I need
        #how to I parse the response and what do I want to do from there
    end

    def self.getIngredients(dinner)
    url = "https://api.spoonacular.com/recipes/#{dinner.dinner_id}/ingredientWidget.json?apiKey=2136f4985e444fff867de5a0c46fb46c"
    response = Net::HTTP.get(URI(url))
    ingredients = JSON.parse(response)
    dinner.ingredients = ingredients["ingredients"]
    end
    # service file/class. It is responsible for talking to Api - going out to it and getting my info and returning it
end
