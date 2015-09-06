class PaymentPlan < ActiveRecord::Base
  #belongs_to :CreditLine
  belongs_to :admin
  belongs_to :credit_line
  has_many :payments
  attr_accessible :birthDate, :identification, :numberOfPayments, :principal, :riskLevel, :state, :CreditLine_id, :admin

  self.per_page = 50
end

WillPaginate.per_page = 50


