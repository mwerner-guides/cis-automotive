class Price
  attr_accessor :type, :name, :average, :median, :std_dev, :p_variance

  def initialize(name:, average:, median:, stdDev:, pVariance:)
    @name = name
    @average = average
    @median = median
    @std_dev = stdDev
    @p_variance = pVariance
  end
end
