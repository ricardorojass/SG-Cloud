class Document < ActiveRecord::Base
  has_many :versions, :dependent => :destroy
  belongs_to :current_version, class_name: "Version"
  accepts_nested_attributes_for :current_version, reject_if: lambda {|attributes| attributes['ubication'].blank?}, allow_destroy: true

  validates :code, :origin, :type, presence: true

  self.inheritance_column = nil
end
