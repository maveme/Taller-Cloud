class CreateCreditLines < ActiveRecord::Migration
  def change
    create_table :credit_lines do |t|
      t.string :name
      t.float :interest_rate
      t.references :admin

      t.timestamps
    end
    add_index :credit_lines, :admin_id
  end
end
