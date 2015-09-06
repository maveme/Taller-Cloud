class CreatePaymentPlans < ActiveRecord::Migration
  def change
    create_table :payment_plans do |t|
      t.string :identification
      t.datetime :birthDate
      t.float :principal
      t.integer :numberOfPayments
      t.string :state
      t.float :riskLevel
      t.references :CreditLine
      t.references :admin

      t.timestamps
    end
    add_index :payment_plans, :CreditLine_id
    add_index :payment_plans, :admin_id
  end
end
