class Contact < ActiveRecord::Base
  validates :name, :number, :presence => true
end
