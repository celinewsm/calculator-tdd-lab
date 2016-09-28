class Calculator
  attr_reader :result , :past_results , :current_index , :cannot_redo

  def initialize result = 0
    @result = result
    @past_results = [result]
    @current_index = 0
    @cannot_redo = true
  end

  def add input = @result
    to_clear
    @result += input
    @current_index += 1
    @past_results.push(@result)
    self
  end

  def subtract input = @result
    to_clear
    @result -= input
    @current_index += 1
    @past_results.push(@result)
    self
  end

  def multiply input = @result
    to_clear
    @result = @result * input
    @current_index += 1
    @past_results.push(@result)
    self
  end

  def divide input = @result
    to_clear
    @result = @result/input.round(2)
    @current_index += 1
    @past_results.push(@result)
    self
  end

  def operation method , input
    if method === "add"
    self.add(input)
    elsif method === "subtract"
    self.subtract(input)
    elsif method === "multiply"
    self.multiply(input)
    elsif method === "divide"
    self.divide(input)
    end
  end

  def reset input = 0
    @result = input
    @past_results = []
    @current_index = 0
  end

  def undo
    @current_index -= 1
    @result = @past_results[@current_index]
  end

  def redo
    if @cannot_redo === false
      @current_index += 1
      @result = @past_results[@current_index]
      @cannot_redo = true
    end
  end

  def to_clear
    @past_results.pop(@past_results.length-@current_index-1)
    # @past_results.pop(2)
    @cannot_redo = false
  end

end
