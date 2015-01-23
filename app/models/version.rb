class Version < ActiveRecord::Base
  belongs_to :document

  validates :number, :ubication, :title, :description, presence: true
  
  enum status: [:in_proccess, :revised, :approved, :rejected]


end
