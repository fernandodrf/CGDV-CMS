ActionMailer::Base.smtp_settings = {
  :address  => "mail.cgdv.org",
  :port  => 25,
  :user_name  => "sistema+cgdv.org",
  :password  => "iQdye!cnXD",
  :authentication  => :login,
  :openssl_verify_mode  => 'none'
}