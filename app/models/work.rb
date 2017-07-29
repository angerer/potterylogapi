class Work < ApplicationRecord
  # model associations
  has_many :logs, dependent: :destroy
  
  # validations
  validates_presence_of :project, :status
end
