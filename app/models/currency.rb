class Currency < ActiveRecord::Base
  belongs_to :exchange

  scope :currency_history, -> (currency) { where('name = ?', currency.name) }

  def average(name_of_column, array_of_currencies)
    array_of_currencies.average(name_of_column).round(4)
  end

  def median(name_of_column, array_of_currencies)
    sorted = array_of_currencies.pluck(name_of_column).sort
    len = sorted.length
    ((sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0).round(4)
  end


end
