class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_rates_mail(user, exchange)
    @user = user
    @exchange = exchange
    mail(to: user.email, subject: 'Exchange rates have been updated.')

  end

end