require './class.rb'

str = 'case a of 1: case end ; end ;'

main = Resolver.new(str)

p main.compile
