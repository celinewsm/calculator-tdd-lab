require 'spec_helper'
require_relative '../calculator_tdd'

describe "Create new Calculator" do
  it "Should result in creating a new class instance" do
    calc1 = Calculator.new
    expect(calc1).to_not be_nil
  end

  it "Instance class should have default value of 0" do
    calc1 = Calculator.new(0)
    expect(calc1.result).to eq(0)
  end

  it "Instance class should have default value of 5" do
    calc1 = Calculator.new(5)
    expect(calc1.result).to eq(5)
  end

end

describe "Addition function" do
  it "Should add 3 to result" do
    calc1 = Calculator.new(0)
    calc1.add(3)
    expect(calc1.result).to eq(3)
  end

  it "Should be able to add negative integer" do
    calc1 = Calculator.new(0)
    calc1.add(-3)
    expect(calc1.result).to eq(-3)
  end

  it "should be able to add decimal values" do
    calc1 = Calculator.new(0)
    calc1.add(0.354)
    expect(calc1.result).to eq(0.354)
  end

  it "should add the result to itself if the input is empty" do
    calc1 = Calculator.new(5)
    calc1.add()
    expect(calc1.result).to eq(10)
  end
end

describe "Subtraction function" do

  it "Should subtract 2 to the result" do
    calc = Calculator.new
    calc.subtract(2)
    expect(calc.result).to eq(-2)
  end

  it "Should subtract randomly generated number to the result" do
    random_input = Random.new.rand(100)
    calc = Calculator.new
    calc.subtract(random_input)
    expect(calc.result).to eq(-random_input)
  end

  it "Should subtract negative integers" do
    calc = Calculator.new
    calc.subtract(-2)
    expect(calc.result).to eq(2)
  end

  it "Should subtract decimal values" do
    calc = Calculator.new(10)
    calc.subtract(0.65)
    expect(calc.result).to eq(9.35)
  end

  it "should subtract the result to itself if the input is empty" do
    calc1 = Calculator.new(5)
    calc1.subtract()
    expect(calc1.result).to eq(0)
  end

end

describe "multiplication function" do
  it "should multiply 5 to the result" do
    calc = Calculator.new(1)
    calc.multiply(5)
    expect(calc.result).to eq(5)
  end

  it "should multiply decimal values to the result" do
    calc = Calculator.new(2)
    calc.multiply(1.65)
    expect(calc.result).to eq(3.3)
  end

  it "should multiply negative integer" do
    calc = Calculator.new(1)
    calc.multiply(-5)
    expect(calc.result).to eq(-5)
  end

  it "should multiply random numbers" do
    random_input = Random.new.rand(100)
    calc = Calculator.new(1)
    calc.multiply(random_input)
    expect(calc.result).to eq(random_input)
  end

  it "should multiply the result to itself if the input is empty" do
    calc1 = Calculator.new(5)
    calc1.multiply()
    expect(calc1.result).to eq(25)
  end

end


describe "Division function" do
  it "should divide 5 to the result" do
    calc = Calculator.new(1)
    calc.divide(5)
    expect(calc.result).to eq(0.2)
  end

  it "should divide decimal values to the result" do
    calc = Calculator.new(2)
    calc.divide(0.4)
    expect(calc.result).to eq(5)
  end

  it "should divide negative integer" do
    calc = Calculator.new(1)
    calc.divide(-5)
    expect(calc.result).to eq(-0.2)
  end

  it "should divide random numbers" do
    random_input = Random.new.rand(100)
    calc = Calculator.new(1)
    calc.divide(random_input)
    expect(calc.result).to eq(1/random_input.round(2))
  end

  it "should divide the result to itself if the input is empty" do
    calc1 = Calculator.new(5)
    calc1.divide()
    expect(calc1.result).to eq(1)
  end

end


describe "Chaining function" do
  it "should return the result of both addition and substraction input" do
    calc1 = Calculator.new(0)
    calc1.add(2).subtract(4)
    expect(calc1.result).to eq(-2)
  end

  it "should return the result of both addition and substraction in large number input" do
    calc1 = Calculator.new(0.5)
    calc1.add(10000000).subtract(50000)
    # (@result += input)).subtract(50000) // don't want this
    # (self).subtract(50000) // want this
    # (calc1).subtract(50000) // same as this
    expect(calc1.result).to eq(9950000.5)
  end

end

describe "Operation function" do
  it "should support add operation" do
    calc1 = Calculator.new(0)
    calc1.operation('add', 10)
    expect(calc1.result).to eq(10)
  end

  it "should support subtract operation" do
    calc1 = Calculator.new(5)
    calc1.operation('subtract', 2)
    expect(calc1.result).to eq(3)
  end

  it "should support multiply operation" do
    calc1 = Calculator.new(2)
    calc1.operation('multiply', 5)
    expect(calc1.result).to eq(10)
  end

  it "should support divide operation" do
    calc1 = Calculator.new(2)
    calc1.operation('divide', 5)
    expect(calc1.result).to eq(0.4)
  end

end

describe "Reset function" do
  it "should reset to value to 0" do
    calc = Calculator.new(9)
    calc.reset(0)
    expect(calc.result).to eq(0)
  end
end

describe "Undo function" do
  it "should undo previous operation, restoring the result value" do
    calc1 = Calculator.new(2)
    calc1.operation('multiply', 5)
    calc1.undo
    expect(calc1.result).to eq(2)
  end
end

describe "Redo function" do
  it "should redo previous operation, restoring the result value" do
    calc1 = Calculator.new(2)
    calc1.operation('multiply', 5)
    calc1.undo
    calc1.redo
    expect(calc1.result).to eq(10)
  end

  it "does this really really work?" do
    calc1 = Calculator.new(2)
    calc1.add(5) #7
    calc1.add(3) #10
    calc1.add(5) #15
    calc1.undo #10
    calc1.redo #15
    calc1.undo #10
    calc1.subtract(1) #9
    expect(calc1.result).to eq(9)
  end

  it "does this really really for real work?" do
    calc1 = Calculator.new(2)
    calc1.add(5)
    calc1.add(5)
    calc1.add(5)
    calc1.add(5)
    calc1.undo
    calc1.redo
    calc1.undo
    calc1.undo
    calc1.add(5)
    calc1.undo
    calc1.add(2)
    expect(calc1.result).to eq(14)
  end

  it "should only allow 1 redo" do
    calc1 = Calculator.new(2)
    calc1.operation('multiply', 5)
    calc1.undo
    calc1.redo
    calc1.undo
    calc1.redo #this line should have no effect if successful
    expect(calc1.result).to eq(2)
  end
end
