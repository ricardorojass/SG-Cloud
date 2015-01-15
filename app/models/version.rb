class Version < ActiveRecord::Base
  belongs_to :document

  def docs_url
    id = self.docdrive_id
    "https://docs.google.com/document/d/#{id}/edit?usp=drive_web"
  end

end
