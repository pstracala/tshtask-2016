require 'spec_helper'

describe Exchange do
  
  it "saves the current rates" do
    expect{
      Exchange.new.save_current_rates
    }.to change(Exchange,:count).by(1)
  end
  
  it "returns true if saved the current rates " do
    Exchange.new.save_current_rates.should == true
  end

  it "returns false if not saved the current rates" do
    Exchange.new.save_current_rates
    Exchange.new.save_current_rates.should_not == true
    expect{
      Exchange.new.save_current_rates
    }.to change(Exchange,:count).by(0)
  end
  
end
