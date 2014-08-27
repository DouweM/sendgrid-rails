module SendGrid
  class MailInterceptor
    def self.delivering_email(mail)
      sendgrid_header = mail.instance_variable_get(:@sendgrid_header)

      if sendgrid_header.data.has_key?(:to) && sendgrid_header.data[:to].present?
        sendgrid_header.add_recipients(mail.to)
        mail.header['to'] = SendGrid.dummy_address if SendGrid.dummy_address
      end
      
      mail.header['X-SMTPAPI'] = sendgrid_header.to_json if sendgrid_header.data.present?
    end
  end
end
