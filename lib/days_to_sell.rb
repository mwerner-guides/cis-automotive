class DaysToSell
  attr_accessor :type, :name, :average, :median, :std_dev, :p_variance, :region_average

  def initialize(name:, average:, median:, stdDev:, pVariance:, regionAverage:)
    @name = name
    @average = average
    @median = median
    @std_dev = stdDev
    @p_variance = pVariance
    @region_average = regionAverage
  end
end
