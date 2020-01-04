require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:comment)}
  end
  
  describe 'validations' do 
    it { should validate_uniqueness_of(:user_id).scoped_to(:comment_id) }
  end
end
