class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body

  validates :name, presence: true, uniqueness: true, length: {minimum: 3, maximum: 15}
  validates :email, presence: true, uniqueness: true 

  has_many :category_maps, dependent: :destroy
  has_many :categories, through: :category_maps, order: :title
  has_many :transactions, dependent: :destroy

  after_create :add_initial_categories


  def addCategory(name, kind)
    name.downcase!
    kind = kind == "true"
    return nil if self.categories.where("title = ? and transaction_type = ?", name, kind).count >= 1
    
    c = Category.where(title: name, transaction_type: kind).limit(1)
    if c.count == 1
      self.categories << c
    else
      Category.create(title: name, transaction_type: kind)
      self.categories << Category.last
    end
    
  end

  
  def getExpenses(p)
    category = p[:filter_category] || "All"
   transaction_type = false

    if category == "All"
      collection = self.transactions
    elsif category == "No Category"
     category_id = ""
    else
      category_id = self.categories.where(title: category.downcase).first.id
    end
    
    date = p[:date]
    
    if date != "custom"
      if date == "day"
        endDate = Date.today
        startDate = Date.today
      elsif date != "All"
        endDate = Date.today
        startDate = Date.today.send("at_beginning_of_#{date}")
      end
    else
      startDate = Date.parse(p[:startDate].to_s)
      endDate = Date.parse(p[:endDate].to_s)
    end
    
    
    if date == "All"
      if category_id
        if category_id == ""
          return self.transactions.where("category_id is ? and transaction_type = ?", nil, transaction_type)
        else
          return self.transactions.where("category_id = ? and transaction_type = ?", category_id, transaction_type)
        end
      else
        return self.transactions.where("transaction_type = ?", transaction_type)
      end
    else
      if category_id
        if category_id == ""
          return self.transactions.where("category_id is ? and transaction_type = ? and date >= ? and date <= ?", nil, transaction_type, startDate, endDate)
        else
          return self.transactions.where("category_id = ? and transaction_type = ? and date >= ? and date <= ?", category_id, transaction_type, startDate, endDate)
        end
      else
        
        return self.transactions.where("transaction_type = ? and date >= ? and date <= ?", transaction_type, startDate, endDate)
      end
    end
  end


  private
  def add_initial_categories
    initial_categories = ["food", "health", "groceries"]
    initial_categories.each do |i|
      cat_id = Category.where(title: i, transaction_type: false).first.id
      CategoryMap.create(user_id: self.id, category_id: cat_id)
    end
        
  end


  
end
