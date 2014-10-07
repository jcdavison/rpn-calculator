require 'pry'
class RPNExpression
  attr_accessor :expr
  # Returns an object representing the supplied RPN expression
  #
  # @param expr [String] an RPN expression, e.g., "5 4 +"
  def initialize(expr)
    @expr = expr
  end

  # Evaluates the underlying RPN expression and returns the final result as a
  # number.
  #
  # @return [Numeric] the evaluated RPN expression
  def evaluate
    stack = []
    rm_whitespace!
    tokens = tokenize!
    tokens.length.times do |n|
      if tokens[n..n+1].join.match(/\d{2}/)
        stack[0] = tokens[n]
      elsif tokens[n..n+1].join.match(/\d{1}(\+|\-|\*|\/)/)
        int = tokens[n]
        operator = tokens[n+1]
        stack[0] = stack[0].send(operator, int)
      end
    end
    stack[0]
  end

  private

  def tokenize!
    @expr.chars.map! {|t| t[/\d/] ? t.to_i : t.to_sym }
  end

  def rm_whitespace!
    @expr.gsub!(" ", "")
  end
end
