class Category < ActiveRecord::Base
  attr_accessible :title, :transaction_type, :user_id

  validates :title, presence: true
  validates :user_id, presence: true
  validates :transaction_type, inclusion: {in: [false, true]}
  validate :not_similar_title

  before_save :capitalize_title

  belongs_to :user 

  def not_similar_title
    if title && user_id && transaction_type != nil
      user = User.find(user_id)
      user.categories.each do |e|
        if e.title.downcase.pluralize == title.downcase.pluralize && transaction_type == e.transaction_type 
          errors.add(:name, "Category with similar name exists already")
          return
        end
      end 
    end
  end

  def capitalize_title
    self.title = self.title.split.map{|i| i.capitalize}.join(" ")
  end
end
