class DailyDownloadRatesWorker
  include Sidekiq::Worker

  def perform
    @exchange = Exchange.new
    
    if @exchange.save_current_rates
      puts 'New rates have been saved at ' + Time.now.strftime("%Y-%m-%d %H:%M:%S")
      User.find_each do |user|
        UserMailer.new_rates_mail(user, @exchange).deliver
      end
    end
  end
  
  Sidekiq::Cron::Job.create(name: 'Refresh exchange rates everyday at 8:30', cron: '30 8 * * *', class: 'DailyDownloadRatesWorker') 
end