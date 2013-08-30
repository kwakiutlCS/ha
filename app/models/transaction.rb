class Transaction < ActiveRecord::Base
  attr_accessible :category_id, :currency, :date, :description, :user_id, :value_cents, :transaction_type

  validates :value_cents, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :user_id, presence: true
  validates :date, presence: true
  validates :description, length: {maximum: 255}
  validates :transaction_type, inclusion: {in: [true, false]}
  
  belongs_to :user
  belongs_to :category

  after_initialize :set_defaults

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

  def self.createTransaction(hash, user)
    result = {}
    hash.each do |k,v|
      if k == "value" 
        v = convertMoneyToCents(v)
        result["value_cents"] = v
      elsif k == "category"
        if v
          cat = user.categories.where(title: v.downcase.singularize)
          result["category_id"] = cat.first.id if cat.count == 1
        end
      else
        result[k] = v
      end
    end
    result
  end
  

  private
  def set_defaults
    self.date ||= Date.today
  end

  def self.convertMoneyToCents(v)
    if v =~ /\..*\./ or v =~ /,.*,/ or v =~ /\..*,/ or v =~ /,.*\./ 
      v = nil
    elsif v =~ /\d*\.\d\d/
      v = v.sub(".","")
    elsif v =~ /\d*\.\d/
      v = v.sub(".","")+"0"
    elsif v =~ /\d+\./
      v = v.sub(".","00")
    elsif v =~ /\d*,\d\d/
      v = v.sub(",","")
    elsif v =~ /\d*,\d/
      v = v.sub(",","")+"0"
    elsif v =~ /\d+,/
      v = v.sub(".","00")
    elsif v =~ /\d+/
      v = v+"00"
    else
      v = nil
    end
    while v != nil && v[0] == "0"
      v = v[1,v.length-1]
    end
    v
  end
end
