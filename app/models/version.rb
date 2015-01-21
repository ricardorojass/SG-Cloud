class Version < ActiveRecord::Base
  belongs_to :document

  validates :number, :ubication, :title, :application_date, :description, presence: true
  

end
