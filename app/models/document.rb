class Document < ActiveRecord::Base
  has_many :versions
  belongs_to :current_version, class_name: "Version"
  accepts_nested_attributes_for :current_version

  self.inheritance_column = nil
end
