require 'spec_helper'

describe MoneyController, :type => :controller do

  before (:each) do
    @user = FactoryGirl.create(:user)
    @exchange = FactoryGirl.create(:exchange)
    sign_in @user
  end

  describe "GET 'index'" do
    before do
      @exchanges = Exchange.all.order(id: :desc)
      get :index
    end

    it "should be successful" do
      response.should be_success
    end

    it "should find all exchanges" do
      assigns(:exchanges).should eq([@exchange])
    end

    it "renders the :index view" do
      response.should render_template :index
    end

  end

  describe "GET 'show'" do
    before do
      @currency = FactoryGirl.create(:currency, exchange_id: @exchange.id)
      get :show, id: @exchange
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should find all currencies" do
      assigns(:currencies).should eq([@currency])
    end

    it "renders the :show view" do
      response.should render_template :show
    end

    it "redirect to index when exchange not find" do
      get :show, id: 123
      response.should redirect_to(money_index_path)
    end
  
  end

  describe "POST 'refresh_rates'" do

    it "should render refresh_rates_saved.js if saved" do
      post :refresh_rates, :format => 'js'
      should render_template('money/refresh_rates_saved')
    end

    it "should render refresh_rates_not_saved.js if not saved" do
      post :refresh_rates, :format => 'js'
      post :refresh_rates, :format => 'js'
      should render_template('money/refresh_rates_not_saved')
    end
    
    it "should add one new exchange" do
      expect{
        post :refresh_rates, :format => 'js'
      }.to change(Exchange,:count).by(1)
    end
    
  end

  describe "POST 'refresh_rates'" do
    before do
      @currency = FactoryGirl.create(:currency, exchange_id: @exchange.id)
      get :report, id: @currency.id
    end

    it "should be successful" do
      response.should be_success
    end

    it "should find currency" do
      assigns(:currency).should eq(@currency)
    end

    it "renders the :report view" do
      response.should render_template :report
    end

    it "redirect to index when currency not find" do
      get :report, id: 123
      response.should redirect_to(money_index_path)
    end

  end

end
