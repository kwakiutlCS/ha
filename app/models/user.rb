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

  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy

  after_create :add_initial_categories

  private
  def add_initial_categories
    titles_expenses = ["health", "grocery", "clothing"] 
    titles_revenues = ["paycheck",]
    titles_expenses.each do |title|
      c = self.categories.build(title: title, transaction_type: false)
      c.save
      
    end
    titles_revenues.each do |title|
      c = self.categories.build(title: title, transaction_type: true)
      c.save
    end
    
  end
end
