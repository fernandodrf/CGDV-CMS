ActionMailer::Base.smtp_settings = {
  :address  => "mail.conganas.org.mx",
  :port  => 26,
  :user_name  => "sistema@conganas.org.mx",
  :password  => "iQdye!cnXD",
  :authentication  => :login,
  :openssl_verify_mode  => 'none'
}