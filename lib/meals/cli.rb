class Cli
    def run
        puts "  "
        puts "Welcome to my meals app!"
        puts "  "

        #first command is to set the main ingredient
        @input = "ingredient"

        while @input != "exit"
            if @input.to_i > 0 && @input.to_i <= Meal.all.length 
                recipe_loop
            else 
                case @input
                when 'list'
                    print_meals(Meal.all)
                    ##go ahead and list my dinners with this ingredient again   
                when "ingredient"
                    #elsif #user picks another dinner
                    puts "Enter a main ingredient to see meals made with that ingredient"
                    puts "  "
                    Meal.clear
                    @main_ingredient = gets.strip.downcase
                    Api.get_meals(@main_ingredient)
                    #next command is forced to be list
                    @input = 'list'
                    next 
                else
                    puts "I do not understand, please try again"
                end
            end
            
            if @input == 'b'
                @input = "list"
                next
            end
            prompt_user
            @input = gets.strip.downcase
        end
        puts"  "
        puts "Thank you for using my app, hope your meal is delicious!"

    end

    def recipe_loop
        meal = Meal.all[@input.to_i - 1] #this is getting the recipe they picked - using the user input subtracting 1 
        Api.getIngredients(meal) #must be before getAnalyzedInstructions
        Api.getAnalyzedInstructions(meal)#user picks a dinner, go ahead and get the detail for that dinner
        while @input != 'b'
            puts "  "
            puts "Recipe: #{meal.name}"
            prompt_user_recipe
            @input = STDIN.getch

            case @input 
            when 'b'
                break #or can return
            when 'i'
                meal.print_ingredients
            when 't'
                instruction_loop(meal)
            end

        end
    end


    def instruction_loop(meal)
        step = 0
        if meal.instructions.length == 0
            puts "No instructions found for that meal"
        else 
            meal.print_instruction(step)
            while @input != 'b'
                prompt_user_instructions
                @input = STDIN.getch

                case @input
                when 'b'
                    @input = '' #only want to go back once
                    break #or return
                when 'n'
                    step -= 1
                    step = 0 if step < 0
                when 'm'
                    step +=1
                    if step == meal.instructions.length
                    step = meal.instructions.length - 1
                    puts "Already on the last step"
                    end
                end
                meal.print_instruction(step)
            end
        end
    end

    def print_meals(meals)
        puts "  "
        puts "Here are the meals made with #{@main_ingredient}:"
        meals.each.with_index(1) do |meal, index|
        #can specify a starting point
            puts "#{index}. #{meal.name}"
        end
        puts "  "
    end

    def prompt_user
        puts "  "
        puts "Enter a number to view the recipe for that meal"
        puts "Enter 'list' to see the list again"
        puts "Enter 'ingredient' to select a new ingredient"
        puts "Enter 'exit' to exit"
        puts "  "
    end

    def prompt_user_recipe
        puts "  "
        puts "Press 'i' to see all ingredients"
        puts "Press 't' to go to instructions"
        puts "Press 'b' to go back"
        puts "  "
    end

    def prompt_user_instructions
        puts "  "
        puts "Press 'n' to go to previous step"
        puts "Press 'm' to go to next step"
        puts "Press 'b' to go back"
        puts "  "
    end
end
