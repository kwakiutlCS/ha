class TrendReport < ActiveRecord::Base
  attr_accessible :title, :x_data, :x_label, :y_data, :y_label

  validates :title, presence: true
  validates :y_label, presence: true
  validates :x_label, presence: true
  validates :y_data, presence: true
  validates :x_data, presence: true
  
  serialize :x_data
  serialize :y_data



  def self.getReport(user, options = {})
    user.transactions.where(:transaction_type: false)
  end
end
