require 'dotenv'
require 'webmock/rspec'
require_relative '../lib/user_fetcher'
require_relative '../lib/user_processor'
require_relative '../lib/user_presenter'

Dotenv.load

RSpec.describe 'Application Integration' do
  let(:api_url) { "#{ENV['API_URL']}/users" }
  let(:user_data) do
    [
      {
        'id' => '1',
        'name' => 'John Doe',
        'email' => 'john.doe@example.com',
        'last_activity' => 1_622_499_200,
        'role' => 'admin',
        'status' => 'enabled'
      },
      {
        'id' => '2',
        'name' => 'Jane Smith',
        'email' => 'jane.smith@gmail.com',
        'last_activity' => 1_622_499_201,
        'role' => 'viewer',
        'status' => 'enabled'
      },
      {
        'id' => '3',
        'name' => 'Inactive User',
        'email' => 'inactive.user@niuco.com.br',
        'last_activity' => 1_622_499_202,
        'role' => 'editor',
        'status' => 'disabled'
      }
    ]
  end

  before do
    stub_request(:get, api_url)
      .to_return(status: 200, body: user_data.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  it 'fetches, processes, and presents the user data correctly' do
    user_fetcher = UserFetcher.new
    users_data = user_fetcher.fetch_users

    processed_users = users_data.map { |user_data| UserProcessor.new(user_data).process }

    expect do
      UserPresenter.new(processed_users).display
    end.to output(a_string_including(
                    'ID: 1',
                    'Name: John Doe',
                    'Email: jo****oe@example.com',
                    "Last Activity: #{Time.at(1_622_499_200).utc.iso8601}",
                    'Active: true',
                    'Paying: true',
                    '-' * 40,
                    'ID: 2',
                    'Name: Jane Smith',
                    'Email: ja******th@gmail.com',
                    "Last Activity: #{Time.at(1_622_499_201).utc.iso8601}",
                    'Active: true',
                    'Paying: false',
                    '-' * 40,
                    'ID: 3',
                    'Name: Inactive User',
                    'Email: inactive.user@niuco.com.br',
                    "Last Activity: #{Time.at(1_622_499_202).utc.iso8601}",
                    'Active: false',
                    'Paying: false',
                    '-' * 40
                  )).to_stdout
  end
end
