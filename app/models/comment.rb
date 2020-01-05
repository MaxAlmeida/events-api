class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :reports, dependent: :destroy
  validates_presence_of :text

  def reported?
    self.reports.count > 0 ? true : false  
  end

end
