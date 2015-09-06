class CreditLine < ActiveRecord::Base
  belongs_to :admin
  has_many :payment_plans
  attr_accessible :interest_rate, :name
end
