require 'httparty'
require 'dotenv'
Dotenv.load

class UserFetcher
  include HTTParty
  base_uri ENV['API_URL']

  def fetch_users
    response = self.class.get('/users')
    if response.success?
      response.parsed_response
    else
      Rails.logger.error "Error fetching users from API: #{response.code} - #{response.message}"
      raise StandardError, 'Error fetching users'
    end
  end
end
