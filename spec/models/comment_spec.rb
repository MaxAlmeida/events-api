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

  describe 'reported?' do
    let!(:event) {create(:event)}
    let!(:user) {create(:user)}
    let!(:comment) {create(:comment, user_id: user.id, event_id: event.id)}
    let!(:comment_without_report) {create(:comment, user_id: user.id, event_id: event.id)}
    let!(:report){create(:report, user_id: user.id, comment_id: comment.id)}

    context "when comment have not report" do
      it{ expect(comment_without_report.reported?).to eq(false) }
    end
    
    context "when comment have report" do
      it{ expect(comment.reported?).to eq(true) }
    end
  end
end
