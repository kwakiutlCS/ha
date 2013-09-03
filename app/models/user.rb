class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body

  validates :name, presence: true, uniqueness: true, length: {minimum: 3}
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

  

  private
  def add_initial_categories
    initial_categories = [21,22,23,24,25]
    initial_categories.each do |i|
      CategoryMap.create(user_id: self.id, category_id: i)
    end
        
  end
end
