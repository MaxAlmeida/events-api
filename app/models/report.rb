class Report < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates_uniqueness_of :user_id, :scope => [:comment_id]
end
