require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:event)}
    it { should have_many(:reports)}
  end
  
  describe 'validations' do
    it {should validate_presence_of(:text)}
  end
end
