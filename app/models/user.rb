class User < ActiveRecord::Base
  validates :friendly_name, :number, :presence => true
  validates :number, :uniqueness => true
  before_create :add_number


end
