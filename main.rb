require './class.rb'

puts 'Input case construction:'
str = gets

main = Resolver.new(str)

if main.compile
  puts 'Tokens:'
  print "#{main.tokens}\n"
  puts 'Case construction is correct'
else
  puts 'Tokens:'
  print "#{main.tokens}\n"
  puts 'Case construction is not correct'
end
