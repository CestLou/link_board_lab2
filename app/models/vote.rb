class Vote < ActiveRecord::Base
  belongs_to :user
  # belongs_to :post
  # belongs_to :comment
  belongs_to :voteable, polymorphic: true
end
