require './class.rb'

str = gets

main = Resolver.new(str)

p main.compile
