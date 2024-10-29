require 'dotenv'
require_relative 'lib/user_fetcher'
require_relative 'lib/user_processor'
require_relative 'lib/user_presenter'

Dotenv.load

user_fetcher = UserFetcher.new
users_data = user_fetcher.fetch_users

if users_data
  processed_users = users_data.map do |user_data|
    begin
      UserProcessor.new(user_data).process
    rescue StandardError => e
      Rails.logger.error "Error processing user: #{e.message}"
      nil
    end
  end.compact  # Remove nil elements from processed_users

  UserPresenter.new(processed_users).display
else
  Rails.logger.error 'Error fetching users from API.'
  puts 'Error fetching users from API.'
end
