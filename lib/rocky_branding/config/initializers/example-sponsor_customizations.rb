BARCODE_PREFIX = "XAM"

SPONSOR_NAME = "Example Org"
SPONSOR_NAME_CGI_ESCAPED = CGI.escape(SPONSOR_NAME)

FACEBOOK_CALLBACK_URL = CGI.escape("http://www.example.org/register/fb")

PARTNER_SIGNUP_URL = "http://www.example.org/partner"

FOOTER_LINK_BASE_URL = "http://www.example.org/voter-registration/online-application-system"

FOOTER_COPYRIGHT = "&copy; Copyright %d, Example Org"

PARTNER_COMARKETING_TEXT = %Q(Numbers not as high as you'd like?\n<a href="http://www.example.org/partner/how-to-get-it-out-there.html" target="_blank">Here are some ways to help market your tool.</a>)

case RAILS_ENV
when "production"
  FROM_ADDRESS = "register@example.org"
  ActionMailer::Base.default_url_options = { :host => "register.example.org" }
when "staging"
  FROM_ADDRESS = "register@example.org"
  ActionMailer::Base.default_url_options = { :host => "ovrstaging.example.org" }
when "development"
  FROM_ADDRESS = "ovr-dev@gmail.com"
  ActionMailer::Base.default_url_options = { :host => "register.example.org" }
else
  FROM_ADDRESS = "ovr@example.org"
  ActionMailer::Base.default_url_options = { :host => "register.example.org" }
end
