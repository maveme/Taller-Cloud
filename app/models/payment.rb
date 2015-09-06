class Payment < ActiveRecord::Base
  belongs_to :payment_plan
  attr_accessible :paymentAmortization, :paymentInterest, :paymentNumber, :pendingBalance, :totalPayment
end
