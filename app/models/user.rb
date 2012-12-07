class User < ActiveRecord::Base
  attr_accessible :email, :full_name, :instagram_id

  has_many :albums
end
