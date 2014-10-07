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
    p @expr.gsub!(" ", "")
    stack = []
    @expr.length.times do |n|
      if @expr[n..n+1].match(/\d{2}/)
        stack[0] = @expr[n].to_i
      elsif @expr[n..n+1].match(/\d{1}(\+|\-|\*|\/)/)
        stack[0] = stack[0].send(@expr[n+1], @expr[n].to_i)
      end
    end
    stack[0]
  end
end
