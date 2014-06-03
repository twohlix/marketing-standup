MANDRILL_CONFIG = YAML.load_file("#{::Rails.root}/config/mandrill.yml")[::Rails.env]

ActionMailer::Base.smtp_settings = {
  :address   => "smtp.mandrillapp.com",
  :port      => 587,
  :enable_starttls_auto => true,
  :user_name => MANDRILL_CONFIG["username"],
  :password  => MANDRILL_CONFIG["api_key"],
  :authentication => 'login',
  :domain => 'balconyinfive.com'
}
