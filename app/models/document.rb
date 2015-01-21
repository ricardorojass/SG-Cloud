class Document < ActiveRecord::Base
  has_many :versions, :dependent => :destroy
  belongs_to :current_version, class_name: "Version"
  accepts_nested_attributes_for :current_version, reject_if: lambda {|attributes| attributes['ubication'].blank?}, allow_destroy: true

  validates :code, :origin, :type, :doc_type, presence: true

  def doc_url
    id = self.current_version.docdrive_id
    if self.doc_type == "doc"
      "https://docs.google.com/document/d/#{id}/edit"
    else
      "https://docs.google.com/spreadsheets/d/#{id}/edit"
    end
  end

  self.inheritance_column = nil
end
