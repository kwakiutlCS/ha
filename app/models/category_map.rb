class CategoryMap < ActiveRecord::Base
  attr_accessible :category_id, :user_id


  belongs_to :user
  belongs_to :category
end
