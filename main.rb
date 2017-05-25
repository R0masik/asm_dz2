require './class.rb'

str = "case a of 1 , 2, 3: a := 5; 4: case b of 3: b := 4; end; end;"

main = Resolver.new(str)

print main.compile