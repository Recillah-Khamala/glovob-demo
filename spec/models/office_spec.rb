require 'rails_helper'

RSpec.describe Office, type: :model do
  describe 'associations' do
    it { should have_many(:orders).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build(:office) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(100) }

    it { should validate_presence_of(:location) }
    it { should validate_length_of(:location).is_at_least(5).is_at_most(200) }

    it { should validate_presence_of(:contact_info) }
    it { should validate_length_of(:contact_info).is_at_least(10).is_at_most(500) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:office)).to be_valid
    end
  end
end

