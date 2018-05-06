module OthersHelper
  def total_year_cost(other)
    costs = other_month_costs(other)
    total = 0
    costs.each do |cost|
      total += cost ? cost : 0
    end
    return total
  end

  def other_month_costs(other)
    costs = [other.apr , other.may , other.jun , other.jul , other.aug , other.sep , other.oct , other.nov , other.dec , other.jan , other.feb , other.mar]
  end

end
