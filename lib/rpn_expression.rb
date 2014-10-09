require 'stack'

class RPNExpression
  attr_accessor :expr , :stack

  def initialize
    @stack = Stack.new
  end

  def evaluate(expr)
    tokens(expr).each do |token|
      operator = is_operator!(token)
      if operator
        rs_int = @stack.pop
        ls_int = @stack.pop
        @stack.push(ls_int.send(operator, rs_int))
      else
        @stack.push(token)
      end
    end
    @stack.peek
  end

  private
  OPERATOR_MAP = {
    "+" => :+,
    "-" => :-,
    "*" => :*,
    "/" => :/
  }

  def is_operator!(element)
    OPERATOR_MAP[element]
  end

  def tokens(expr)
    expr.split(" ").map! { |t| t[/^-?\d*$/] ? t.to_i : t }
  end
end
