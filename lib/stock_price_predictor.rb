require_relative 'standard_deviation'

class StockPricePredictor
  def initialize(calculator, starting_price, ending_price, iterations,
      retracement_level = 1, return_float = false)
    @calculator = calculator
    @starting_price = return_float ? starting_price.to_f : starting_price
    @ending_price = return_float ? ending_price.to_f : ending_price
    @iterations = iterations
    @retracement_level = retracement_level
    @return_float = return_float
  end

  # Public API methods
  def rebound
    if @return_float
      retracement_predictions.mean.round(2)
    else
      retracement_predictions.mean.to_i
    end
  end

  def predicted_price
    if @return_float
      (@ending_price + rebound).round(2)
    else
      (@ending_price + rebound).to_i
    end
  end

  def deviation
    if @return_float
      retracement_predictions.standard_deviation.round(2)
    else
      retracement_predictions.standard_deviation.to_i
    end
  end

  private
  def retracement(iterations = nil)
    @iterations = iterations unless iterations.nil?
    result = (primary_adjustment / adjustment_ratio)
    # (high - low) / (Fib(Y) / Fib(X))
    @return_float ? result.to_f : result.to_i
  end

  def retracement_predictions
    @predictions ||= [].tap do |values|
      @iterations.times do |count|
        values << retracement(count+1)
      end
    end
  end

  def primary_adjustment
    @starting_price - @ending_price
  end

  def adjustment_ratio
    # Fib(X+level) / Fib(X)
    @calculator.calculate(
      @iterations + @retracement_level
    ).to_f / @calculator.calculate(@iterations).to_f
  end

end