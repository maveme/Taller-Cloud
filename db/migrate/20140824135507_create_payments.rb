class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :paymentNumber
      t.float :paymentInterest
      t.float :paymentAmortization
      t.float :pendingBalance
      t.float :totalPayment
      t.references :payment_plan

      t.timestamps
    end
    add_index :payments, :payment_plan_id
  end
end
