class MoneyController < ApplicationController
  before_filter :authenticate_user!



  def index
    #show list of exchange rates with creation time
    #don't forget about pagination
    set_exchanges
  end

  def show
    #show table of currencies for selected exchange rate
    @exchange = Exchange.find_by_id(params[:id])
    if @exchange
      @currencies = @exchange.currencies.paginate(:page => params[:page], :per_page => 10)
    else
      redirect_to_rates_index
    end
  end

  def refresh_rates
    #for manual refreshing
    #get latest exchange rates and save to db
    #can be helpful: 
    #http://www.nbp.pl/home.aspx?f=/kursy/instrukcja_pobierania_kursow_walut.html
    @exchange = Exchange.new
    
    if @exchange.save_current_rates
      flash.now[:notice] = 'Rates has been updated.'
      render 'refresh_rates_saved'
    else
      flash.now[:danger] = 'Rates are up-to-date.'
      render 'refresh_rates_not_saved'
    end
  end

  def report
    #generate a report for selected currency
    #report should show: basic statistics: mean, median, average
    #also You can generate a simple chart(use can use some js library)

    #this method should be available only for currencies which exist in the database 

    @currency = Currency.find_by_id(params[:id])
    if @currency
      @currency_history = Currency.currency_history(@currency).order(id: :desc)
      @average_buy_price = @currency.average(:buy_price, @currency_history)
      @average_sell_price = @currency.average(:sell_price, @currency_history)
      @median_buy_price = @currency.median(:buy_price, @currency_history)
      @median_sell_price = @currency.median(:sell_price, @currency_history)
      #chart
      @labels = Exchange.all.pluck(:name)
      @sell_price_history = Currency.currency_history(@currency).order(id: :asc).pluck(:sell_price)
      @buy_price_history = Currency.currency_history(@currency).order(id: :asc).pluck(:buy_price)
    else
      redirect_to_rates_index
    end
  end
  
  private
  
  def set_exchanges
    @exchanges = Exchange.all.order(id: :desc).paginate(:page => params[:page], :per_page => 10)
  end
  
  def redirect_to_rates_index
    flash[:danger] = 'Wrong rate id!'
    redirect_to action: "index"
  end

end
