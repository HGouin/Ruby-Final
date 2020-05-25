#listing all dependencies for project

require "pry"
require "httparty" #interacting with api
require "json" #parse data from api into json
require 'io/console' #not needed in gemfile because it is native to Ruby - it is for STDIN.getch 

require_relative "./meals/cli"
require_relative "./meals/api"
require_relative "./meals/meal"
require_relative "./meals/ingredient"
require_relative "./meals/instruction"

SPOONACULAR_API_KEY = "2136f4985e444fff867de5a0c46fb46c"