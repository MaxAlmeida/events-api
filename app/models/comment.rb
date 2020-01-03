class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :reports
  validates_presence_of :text
end
