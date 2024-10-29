require 'date'

class UserProcessor
  def initialize(user_data)
    @user_data = user_data
  end

  def process
    {
      id: @user_data['id'],
      name: @user_data['name'],
      email: obfuscate_email(@user_data['email']),
      last_activity: convert_last_activity(@user_data['last_activity']),
      active: active?(@user_data['status']),
      paying: paying_user?(@user_data['status'], @user_data['role'])
    }
  rescue KeyError => e
    Rails.logger.error "Missing key in user data: #{e.message}"
    nil
  end

  private

  def active?(status)
    status == 'enabled'
  end

  def paying_user?(status, role)
    return false unless active?(status)

    %w[admin editor].include?(role)
  end

  def convert_last_activity(timestamp)
    Time.at(timestamp).utc.iso8601
  end

  def obfuscate_email(email)
    return email if email.include?('@niuco.com.br')

    alias_name, domain = email.split('@')
    return email if alias_name.length <= 4

    "#{alias_name[0, 2]}#{'*' * (alias_name.length - 4)}#{alias_name[-2, 2]}@#{domain}"
  end
end
