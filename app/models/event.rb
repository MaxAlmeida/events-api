class Event < ApplicationRecord
    has_many :comments, dependent: :destroy

    validates_presence_of :name, :description, :latitude, :longitude
end
