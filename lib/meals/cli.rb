class Cli
    def run
        puts "  "
        puts "Welcome to my meals app!"
        puts "  "

        #ask them to pick a dinner
        input = "ingredient"

        while input != "exit"
            if input == 'list'
                print_dinners(Dinner.all)
                ##go ahead and list my dinners with this ingredient again
            elsif input.to_i > 0 && input.to_i <= Dinner.all.length 
                dinner = Dinner.all[input.to_i - 1]
                Api.getIngredients(dinner)
                Api.getAnalyzedInstructions(dinner)#user picks a dinner, go ahead and get the detail for that dinner
                while input != 'x'
                    puts "  "
                    puts "Recipe: #{dinner.name}"
                    prompt_user_recipe
                    input = STDIN.getch
                    
                    if input == 'x'
                        break
                    elsif input == 'i'
                        dinner.print_ingredients
                    elsif input == 't'
                        step = 0
                        puts "#{step+1}. #{dinner.analyzed_instructions[step]["step"]}"
                        while input != 'x'
                            prompt_user_instructions
                            input = STDIN.getch
                            if input == 'x'
                                input = ''
                                break
                            elsif input == 'n'
                                step -= 1
                                step = 0 if step < 0
                            elsif input == 'm'
                                step +=1
                                if step == dinner.analyzed_instructions.length
                                  step = dinner.analyzed_instructions.length - 1
                                  puts "Already on the last step"
                                end
                            end
                            puts "#{step+1}. #{dinner.analyzed_instructions[step]["step"]}"
                        end
                    end
                end
            elsif input == "ingredient"
                #elsif #user picks another dinner
                puts "Enter a main ingredient to see dinners made with that ingredient"
                puts "  "
                Dinner.clear
                @main_ingredient = gets.strip.downcase
                Api.get_dinners(@main_ingredient)
                input = 'list'
                next
            else 
                puts "I do not understand, please try again"
                binding.pry
            end
            prompt_user
            input = gets.strip.downcase
        end
        puts"  "
        puts "Thank you for using my app, hope your dinner is delicious!"

        #goal go to api and ask for dinners with that ingredient and the api will return data for me and I will use it to display more info for the user
    end
    def print_dinners(dinners)
        puts "  "
        puts "Here are the dinners made with #{@main_ingredient}:"
        dinners.each.with_index(1) do |dinner, index|
        #can specify a starting point
            puts "#{index}. #{dinner.name}"
        end
        puts "  "
    end

    def prompt_user
        puts "  "
        puts "select a number to see the instructions for a dinner"
        puts "type 'list' to see the list again"
        puts "type 'ingredient' to select a new ingredient"
        puts "type 'exit' to exit"
        puts "  "
    end

    def prompt_user_recipe
        puts "  "
        puts "press 'i' to see all ingredients"
        puts "press 't' to go to instructions"
        puts "press 'x' to exit"
        puts "  "
    end

    def prompt_user_instructions
        puts "  "
        puts "press 'n' to go to previous step"
        puts "press 'm' to go to next step"
        puts "press 'x' to exit"
        puts "  "
    end


    #instance method called run for executing program
    # handles input FROM my user and output TO my user
end
