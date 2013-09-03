class Category < ActiveRecord::Base
  attr_accessible :title, :transaction_type

  validates :title, presence: true
  validates :transaction_type, inclusion: {in: [false, true]}
  validate :title_uniqueness
  
  before_create :downcase_title

  has_many :category_maps, dependent: :destroy

  private
  def downcase_title
    self.title = self.title.downcase
  end


  def title_uniqueness
    if self.title && self.transaction_type != nil
      c = Category.where(title: self.title.downcase, transaction_type: self.transaction_type).limit(1).count
      errors.add(:title, "duplicated") if c == 1
    end
    
  end
  
  
    
end
