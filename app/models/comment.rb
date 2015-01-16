class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :voteable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable
end
