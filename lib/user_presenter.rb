class UserPresenter
  def initialize(users)
    @users = users
  end

  def display
    @users.each do |user|
      begin
        puts "ID: #{user[:id]}"
        puts "Name: #{user[:name]}"
        puts "Email: #{user[:email]}"
        puts "Last Activity: #{user[:last_activity]}"
        puts "Active: #{user[:active]}"
        puts "Paying: #{user[:paying]}"
        puts '-' * 40
      rescue StandardError => e
        Rails.logger.error "Error displaying user: #{e.message}"
      end
    end
  end
end
