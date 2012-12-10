class User < ActiveRecord::Base
  attr_accessible :email, :full_name, :instagram_id

  has_many :albums

	validates :email, :email_format => {:notice => 'Please enter a valid email address.'}
  validates_presence_of :full_name, :instagram_id
  validates_uniqueness_of :instagram_id
end
