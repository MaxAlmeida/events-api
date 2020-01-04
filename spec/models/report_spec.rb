require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:comment)}
  end
  
  describe 'validations' do 
    let!(:event) {create(:event)}
    let!(:user) {create(:user)}
    let!(:comment) {create(:comment, user_id: user.id, event_id: event.id)}
    let!(:report){create(:report, user_id: user.id, comment_id: comment.id)}

    it { should validate_uniqueness_of(:user_id).scoped_to(:comment_id) }
  end
end
