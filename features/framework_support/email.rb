require 'mail'
# Class that lets you send emails to multiple recipients with attachments if needed
class Email

  def initialize(delivery_method = 'smtp')
    @mail = Mail.new do
    end
    options = SettingsHelper.email_options
    options = options.transform_keys(&:to_sym)
    Mail.defaults do
      delivery_method delivery_method.to_sym, options
    end
  end

  def from(address)
    @mail[:from] = address
  end

  # @param [Array<String>] recipients_list: List of email's recipients
  def to_recipients(recipients_list)
    @mail[:to] = recipients_list
  end

  def subject(subject)
    @mail.subject = subject
  end

  def body(body_message)
    @mail.body = body_message
  end

  # @param [String] filename: The path of the file to send
  def add_attachment(filename)
    @mail.add_file filename
  end

  def send
    Mail.deliver @mail
  end

end