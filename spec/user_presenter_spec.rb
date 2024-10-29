require 'user_presenter'

RSpec.describe UserPresenter do
  let(:processed_users) do
    [
      {
        id: '123',
        name: 'John Doe',
        email: 'jo******oe@example.com',
        last_activity: '2022-05-15T14:00:00Z',
        active: true,
        paying: true
      }
    ]
  end

  subject { described_class.new(processed_users) }

  describe '#display' do
    it 'outputs formatted user data to console' do
      expect { subject.display }.to output(/ID: 123/).to_stdout
      expect { subject.display }.to output(/Name: John Doe/).to_stdout
      expect { subject.display }.to output(/Email: jo\*\*\*\*\*\*oe@example.com/).to_stdout
      expect { subject.display }.to output(/Last Activity: 2022-05-15T14:00:00Z/).to_stdout
      expect { subject.display }.to output(/Active: true/).to_stdout
      expect { subject.display }.to output(/Paying: true/).to_stdout
    end
  end
end
