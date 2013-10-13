require 'fibonacci_calculator'

describe FibonacciCalculator do
  subject(:calculator) {FibonacciCalculator.new(method)}

  context "invalid method" do
    let(:method) { :invalid }

    it "should raise an UnknownMethodError" do
      expect { calculator.calculate(5) }.
        to raise_error(FibonacciCalculator::UnknownMethodError)
    end
  end

  context "no method, uses default" do
    subject(:calculator) { FibonacciCalculator.new }

    it "should NOT raise an UnknownMethodError" do
      expect { calculator.calculate(5) }.not_to raise_error
    end
  end

  let(:test_values) {
    { 0=>0, 1=>1, 2=>1, 3=>2, 4=>3, 5=>5, 6=>8,
      7=>13, 8=>21, 9=>34, 10=>55, 11=>89, 12=>144,
      13=>233, 14=>377, 15=>610, 16=>987, 17=>1597,
      18=>2584,19=>4181,20=>6765 }
    }

  context "via recursion method" do
    let(:method) { :recursion }

    it "should calculate fib(x) for x: 0-20" do
      test_values.each do |input, output|
        calculator.calculate(input).should == output
      end
    end

    it "should return the 1st 20 sequence values" do
      calculator.sequence(20).should ==
      [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89,
      144, 233, 377, 610, 987, 1597, 2584, 4181]
    end
  end

  context "via iteration method" do
    let(:method) { :iteration }

    it "should calculate fib(x) for x: 0-20" do
      test_values.each do |input, output|
        calculator.calculate(input).should == output
      end
    end

    it "should return the 1st 20 sequence values" do
      calculator.sequence(20).should ==
      [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89,
      144, 233, 377, 610, 987, 1597, 2584, 4181]
    end
  end

  context "via array method" do
    let(:method) { :array }

    it "should calculate fib(x) for x: 0-20" do
      test_values.each do |input, output|
        calculator.calculate(input).should == output
      end
    end

    it "should return the 1st 20 sequence values" do
      calculator.sequence(20).should ==
      [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89,
      144, 233, 377, 610, 987, 1597, 2584, 4181]
    end
  end

  context "via matrix method" do
    let(:method) { :matrix }

    it "should calculate fib(x) for x: 0-20" do
      test_values.each do |input, output|
        calculator.calculate(input).should == output
      end
    end

    it "should return the 1st 20 sequence values" do
      calculator.sequence(20).should ==
      [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89,
      144, 233, 377, 610, 987, 1597, 2584, 4181]
    end
  end

  context "timing between four methods" do
    let(:value) { 30 }
    it "should compare the four methods' runtimes" do
      methods_and_runtimes = {}
      [:recursion, :iteration, :array, :matrix].
      each do |method|
        start_time = Time.now
        result = FibonacciCalculator.new(method).calculate(value)
        end_time = Time.now
        methods_and_runtimes[method] = (end_time - start_time) * 1
      end

      puts "\nFour Fib Methods => Fib(30):\n"
      methods_and_runtimes.each do |method, runtime|
        puts "\tMethod #{method} => in #{runtime} seconds"
      end
    end
  end

  context "timing between three fast methods" do
    let(:value) { 250000 }
    it "should compare the three methods' runtimes" do
      methods_and_runtimes = {}
      [:iteration, :array, :matrix].
      each do |method|
        start_time = Time.now
        result = FibonacciCalculator.new(method).calculate(value)
        end_time = Time.now
        methods_and_runtimes[method] = (end_time - start_time) * 1
      end

      puts "\nThree Fast Fib Methods => Fib(250,000):\n"
      methods_and_runtimes.each do |method, runtime|
        puts "\tMethod #{method} => in #{runtime} seconds"
      end
    end
  end

  context "Using the Matrix computation for a million" do
    let(:value) { 1000000 }
    it "should compare the three methods' runtimes" do
      start_time = Time.now
      result = FibonacciCalculator.new(:matrix).calculate(value)
      end_time = Time.now
      runtime = end_time - start_time

      puts "\nMatrix for a Million => Fib(1,000,000):\n"
      puts "\tMethod MATRIX => in #{runtime} seconds"
      puts "\tFib(million) digits: #{result.size}"
    end
  end

end