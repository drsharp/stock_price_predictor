# Fibonacci Sequence
#  0, 1, 2, 3, 4, 5, 6,  7,  8,  9, 10
#  v  v  v  v  v  v  v   v   v   v   v
#  0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
class FibonacciCalculator
  require 'matrix'
  FIB_MATRIX = Matrix[[1,1],[1,0]]

  class UnknownMethodError < StandardError; end

  def initialize(method = :matrix)
    @method = method
    raise UnknownMethodError unless
      [:recursion, :iteration, :array, :matrix].
        include?(method)
  end

  def calculate(value)
    send(@method, value)
  end

  def sequence(count)
    [].tap do |values|
      count.times { |number| values << calculate(number) }
    end
  end

  private

  def recursion(value)
    return value if (0..1).include? value
    return recursion(value-1) + recursion(value-2)
  end

  def iteration(value)
    curr = 0
    succ = 1
    value.times do |i|
      curr, succ = succ, curr + succ
    end
    return curr
  end

  def array(value)
    return value if value < 2
    vals = [0, 1]
    (value-1).times do
      vals.push(vals[-1] + vals[-2])
    end
    return vals.last
  end

  def matrix(value)
    return (FIB_MATRIX**(value-1))[0,0]
  end
end
