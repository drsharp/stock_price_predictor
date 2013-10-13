require 'stock_price_predictor'
require 'fibonacci_calculator'

describe StockPricePredictor do
  let(:starting_price)    { 100 }
  let(:ending_price)      { 40 }
  let(:iterations)      { 7 }
  let(:calculator) { FibonacciCalculator.new }
  subject { StockPricePredictor.new(calculator, starting_price, ending_price, iterations, retracement_level, use_floats)}


  context "First Retracement Level via Float" do
    let(:retracement_level) { 1 }
    let(:use_floats) { true }

    its(:retracement) { should == 37.14285714285714 }
    its(:retracement_predictions) {
      should == [60.0, 30.0, 40.0, 36.0, 37.5,
        36.92307692307692,37.14285714285714] }
    its(:rebound) { should == 39.65 }
    its(:deviation) { should == 9.48 }
    its(:predicted_price) { should == 79.65 }
  end # First Retracement - Float

  context "First Retracement Level via Integer" do
    let(:retracement_level) { 1 }
    let(:use_floats) { false }

    its(:retracement) { should == 37 }
    its(:retracement_predictions) {
      should == [60, 30, 40, 36, 37, 36, 37] }
    its(:rebound) { should == 39 }
    its(:deviation) { should == 9 }
    its(:predicted_price) { should == 79 }
  end # First Retracement - Integer

  context "Second Retracement Level via Integer" do
    let(:retracement_level) { 2 }
    let(:use_floats) { false }

    its(:retracement) { should == 22 }
    its(:retracement_predictions) {
      should == [30, 20, 24, 22, 23, 22, 22] }
    its(:rebound) { should == 23 }
    its(:deviation) { should == 3 }
    its(:predicted_price) { should == 63 }
  end # Second Retracement - Integer

  context "Third Retracement Level via Integer" do
    let(:retracement_level) { 3 }
    let(:use_floats) { false }

    its(:retracement) { should == 14 }
    its(:retracement_predictions) {
      should == [20, 12, 15, 13, 14, 14, 14] }
    its(:rebound) { should == 14 }
    its(:deviation) { should == 2 }
    its(:predicted_price) { should == 54 }
  end # Third Retracement - Integer
end
