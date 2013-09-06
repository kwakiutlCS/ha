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
    Transaction.format_money(value_cents)
  end

   def category
    return Category.find(category_id).title if category_id
    "No Category"
  end

  def self.createTransaction(hash, user)
    result = {}
    hash.each do |k,v|
      if k == "value" 
        v = convertMoneyToCents(v)
        return nil if v == nil || v.length >= 12
        result["value_cents"] = v
      elsif k == "category"
        if v
          cat = user.categories.where(title: v.downcase).limit(1)
          result["category_id"] = cat.first.id if cat.count == 1
        end
      elsif k == "date"
        begin
          result["date"] = Date.parse(v) ? v : nil        
        rescue
          return nil
        end
      else
        result[k] = v
      end
    end
    result
  end
  

  def self.getTotal(collection)
    total = 0
    collection.each do |c|
      total+= c.value_cents
    end
    return self.format_money(total)
  end

  private
  def set_defaults
    self.date ||= Date.today
  end

  def self.convertMoneyToCents(v)
    return nil if v.length > 13
    if v =~ /\..*\./ or v =~ /,.*,/ or v =~ /\..*,/ or v =~ /,.*\./ 
      return nil
    end
  
    while v =~ /\d*\.\d{3}/
      v = v[0,v.length-1]
    end

    if v == ""
      return "0"
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
      return nil
    end
    while v[0] == "0"
      v = v[1,v.length-1]
    end
    v
  end

  def self.format_money(x)
    money = "$"+(x/100.to_f).to_s
    if money =~ /\.\d$/
      money = money+"0"
    elsif money =~ /\.\d\d/
      money = money
    else
      money = money+".00"
    end
    money
  end
end
