require 'user_fetcher'
require 'webmock/rspec'

RSpec.describe UserFetcher do
  let(:api_url) { 'http://0.0.0.0:8080/users' }
  let(:user_data) do
    [
      {
        'id' => '1',
        'name' => 'John Doe',
        'email' => 'john.doe@example.com',
        'last_activity' => 1_622_499_200,
        'role' => 'admin',
        'status' => 'enabled'
      }
    ]
  end

  before do
    stub_request(:get, api_url)
      .to_return(status: 200, body: user_data.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  it 'fetches users from the API' do
    fetcher = UserFetcher.new
    response = fetcher.fetch_users
    expect(response).to eq(user_data)
  end
end
