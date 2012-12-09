class User < ActiveRecord::Base
  attr_accessible :email, :full_name, :instagram_id

  has_many :albums

  validates_presence_of :email, :full_name, :instagram_id
  validates_uniqueness_of :instagram_id

end
