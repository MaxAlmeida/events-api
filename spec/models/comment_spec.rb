require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:event)}
  it { should have_many(:reports)}
  it {should validate_presence_of(:text)}
  
end
