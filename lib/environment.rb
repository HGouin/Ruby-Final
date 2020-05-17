#listing all dependencies for project

require "pry"
require "httparty" #interacting with api
require "json" #parse data from api into json
require 'io/console'

require_relative "./meals/cli"
require_relative "./meals/api"
require_relative "./meals/meal"
require_relative "./meals/ingredient"
require_relative "./meals/instruction"