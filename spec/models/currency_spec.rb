require 'spec_helper'

describe Currency do
  before do
    @exchange1 = FactoryGirl.create(:exchange)
    @exchange2 = FactoryGirl.create(:exchange)
    @currency11 = FactoryGirl.create(:currency, exchange_id: @exchange1.id)
    @currency12 = FactoryGirl.create(:currency, name: @currency11.name, exchange_id: @exchange2.id)
    @currency21 = FactoryGirl.create(:currency, exchange_id: @exchange2.id)
  end
  
  it "returns currencies only with the same name in currency_history scope" do
    Currency.currency_history(@currency11).should == [@currency11, @currency12]
  end
  
  it "returns average of column rounded to 4 places" do
    @currency_history = Currency.currency_history(@currency11)
    @currency11.average(:buy_price, @currency_history).should == @currency_history.average(:buy_price).round(4)
  end

  it "returns median of column rounded to 4 places" do
    @currency_history = Currency.currency_history(@currency11)
    sorted = @currency_history.pluck(:buy_price).sort
    len = sorted.length
    @currency11.median(:buy_price, @currency_history).should == ((sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0).round(4)
  end

end
