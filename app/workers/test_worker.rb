class TestWorker
  include Sidekiq::Worker

  def perform
    @exchange = Exchange.new

    @exchange.save_current_rates
    puts 'SAVED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
  end

  Sidekiq::Cron::Job.create(name: 'Refresh exchange rates everyday at 13', cron: '* * * * * *', class: 'TestWorker') 
end