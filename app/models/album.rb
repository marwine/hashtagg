class Album < ActiveRecord::Base
  attr_accessible :name, :tag, :user_id

  belongs_to :user
end
