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
  has_many :categories, through: :category_maps
  has_many :transactions, dependent: :destroy

  after_create :add_initial_categories

  private
  def add_initial_categories
    initial_categories = [21,22,23,24,25]
    initial_categories.each do |i|
      CategoryMap.create(user_id: self.id, category_id: i)
    end
        
  end
end
