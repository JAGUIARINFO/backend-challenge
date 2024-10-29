require 'user_processor'

RSpec.describe UserProcessor do
  let(:user_data) do
    {
      'id' => '123',
      'name' => 'Test User',
      'email' => 'test.user@gmail.com',
      'status' => 'enabled',
      'role' => 'editor',
      'last_activity' => 1_649_179_152
    }
  end

  subject { described_class.new(user_data) }

  describe '#process' do
    it 'returns a hash with required keys' do
      result = subject.process
      expect(result).to include(:id, :name, :email, :last_activity, :active, :paying)
    end
  end

  describe '#active?' do
    it 'returns true when status is enabled' do
      expect(subject.send(:active?, 'enabled')).to be true
    end

    it 'returns false when status is disabled' do
      expect(subject.send(:active?, 'disabled')).to be false
    end
  end

  describe '#paying_user?' do
    it 'returns true if user is active and role is editor or admin' do
      expect(subject.send(:paying_user?, 'enabled', 'editor')).to be true
    end

    it 'returns false if user is inactive regardless of role' do
      expect(subject.send(:paying_user?, 'disabled', 'admin')).to be false
    end

    it 'returns false if user role is viewer or system' do
      expect(subject.send(:paying_user?, 'enabled', 'viewer')).to be false
    end
  end

  describe '#convert_last_activity' do
    it 'converts last_activity timestamp to ISO-8601 format' do
      result = subject.send(:convert_last_activity, 1_649_179_152)
      expect(result).to eq(Time.at(1_649_179_152).utc.iso8601)
    end
  end

  describe '#obfuscate_email' do
    it 'obfuscates email if domain is not niuco.com.br' do
      result = subject.send(:obfuscate_email, 'test.user@gmail.com')
      expect(result).to eq('te*****er@gmail.com')
    end

    it 'returns full email if domain is niuco.com.br' do
      result = subject.send(:obfuscate_email, 'test.user@niuco.com.br')
      expect(result).to eq('test.user@niuco.com.br')
    end
  end
end
