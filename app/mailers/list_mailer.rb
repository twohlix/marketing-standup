class ListMailer < ActionMailer::Base
  default from: "info@balconyinfive.com"

  def confirm_email(email)
    @email = email
    @confirm_key = @email.confirmation_key
    mail subject: 'Confirm Your Subscription', to: @email.address
  end
end
