class Resolver
  def initialize(s)
    @str = s
    @tokens = []
    @counter = 0
  end

  def compile
    scan @str, @tokens
    if @tokens.empty?
      false
    else
      caseanls(@tokens) == true && @counter.zero?
    end
  end

  def scan(s, tokens)
    s.split.each do |el|
      case el
        when 'case', 'of', 'end', ':='
          tokens << el
        else
          case el[-1]
            when ':'
              el.chop.split(',').each do |x|
                if x.to_i.to_s == x
                  tokens << 'num'
                  tokens << ','
                end
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
                el.chop.split(',').each do |x|
                  if x.to_i.to_s == x
                    tokens << 'num'
                    tokens << ','
                  end
                end
              end
            else
              if el.to_i.to_s == el
                tokens << 'num'
              elsif el =~ /^[a-zA-Z]+[a-zA-Z0-9]*$/
                tokens << 'id'
              else
                tokens.clear
                break
              end
          end
      end
    end
  end

  def caseanls(tokens)
    @counter += 1
    state = 0
    i = 0
    while i < tokens.size
      if !state
        break
      else
        if state == 5 && tokens[i] == 'case'
          state = caseanls(tokens[i..(tokens[i..-1].index('end') + i)])
          i = tokens[i..-1].index('end') + i
        else
          state = table(state, tokens[i])
        end
      end
      i += 1
    end
    state
  end

  def table(st, tok)
    case st
      when 0
        1 if tok == 'case'
      when 1
        2 if tok == 'id'
      when 2
        3 if tok == 'of'
      when 3
        4 if tok == 'num'
      when 4
        if tok == ','
          3
        else
          5 if tok == ':'
        end
      when 5
        6 if tok == 'id'
      # for tok == 'case' state changes in caseanls
      when 6
        7 if tok == ':='
      when 7
        8 if tok == 'id' || tok == 'num'
      when 8
        if tok == ';'
          9
        elsif tok == 'end'
          @counter -= 1
          10
        end
      when 9
        if tok == 'num'
          4
        elsif tok == 'end'
          @counter -= 1
          10
        end
      when 10
        if tok == 'end'
          @counter -= 1
          10
        else
          tok == ';'
        end
      when true
        if tok == 'num'
          4
        elsif tok == 'end'
          @counter -= 1
          10
        end
      else
        false
    end
  end

  attr_accessor :str
  attr_reader :tokens
end
