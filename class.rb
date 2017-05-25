class Resolver
  def initialize(s)
    @str = s
    @tokens = []
  end

  def compile
    scan @str, @tokens
    caseanls @tokens
  end

  def scan(s, tokens)
    s.split.map do |el|
      case el
        when 'case', 'of', 'end', ':='
          tokens << el
        else
          case el[-1]
            when ':'
              el.chop.split(',').each do |_x|
                tokens << 'num'
                tokens << ','
              end
              tokens.pop
              tokens << ':'
            when ';'
              scan el[0..-2], tokens
              tokens << ';'
            when ','
              if el == ','
                tokens << el
              else
                el.chop.split(',').each do |_x|
                  tokens << 'num'
                  tokens << ','
                end
              end
            else
              if el.to_i.to_s == el
                tokens << 'num'
              else
                if el =~ /^[a-zA-Z]+[a-zA-Z0-9]*$/
                  tokens << 'id'
                else
                  tokens.clear
                  break
                end
              end
          end
      end
    end
  end

  def caseanls(tokens)
    state = 1
    state
  end

  attr_accessor :str
end