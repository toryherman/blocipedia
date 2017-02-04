class MyMailer < ApplicationMailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views
  default from: 'tory.herman12@gmail.com'

  def confirmation_instructions(record, token, opts={})
    headers["Message-ID"] = "Blocipedia Confirmation"
    headers["In-Reply-To"] = "Blocipedia Confirmation"
    headers["References"] = "Blocipedia Confirmation"

    mail(to: current_user.email, subject: "Blocipedia Confirmation")
  end
end
