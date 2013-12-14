class Repo < ActiveRecord::Base
  validates :name, presence: true
end
