require './class.rb'

puts 'Input case construction:'
str = gets

main = Resolver.new(str)

if main.compile
  puts 'Case construction is correct'
else
  puts 'Case construction is not correct'
end
