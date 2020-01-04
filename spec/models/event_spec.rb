require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it{ should have_many(:comments).dependent(:destroy)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:latitude)}
    it { should validate_presence_of(:longitude)}
  end
end
