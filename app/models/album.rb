class Album < ActiveRecord::Base
  attr_accessible :name, :tag, :user_id

  belongs_to :user

  validates_presence_of :name, :tag, :user_id
  validates_uniqueness_of :name, :scope => [:user_id], :case_sensitive => false
  validates_uniqueness_of :tag, :scope => [:user_id], :case_sensitive => false
end
