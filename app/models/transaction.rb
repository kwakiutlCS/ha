class Transaction < ActiveRecord::Base
  attr_accessible :category_id, :currency, :date, :description, :user_id, :value_cents

  validates :value_cents, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :user_id, presence: true
  validates :date, presence: true
  validates :description, length: {maximum: 255}

  belongs_to :user
  belongs_to :category

  def value
    money = "$"+(value_cents/100.to_f).to_s
    if money =~ /\.\d$/
      money = money+"0"
    elsif money =~ /\.\d\d/
      money = money
    else
      money = money+".00"
    end
    money
  end

   def category
    return Category.find(category_id).title if category_id
    "None"
  end

  
  
end
