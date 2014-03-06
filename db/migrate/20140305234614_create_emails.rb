class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :address, null: false, index: :unique
      t.boolean :confirmed, default: false
      t.string :confirmation_key
      t.datetime :confirmation_send_date
      t.datetime :confirmation_date
      t.integer :confirmation_attempts

      t.timestamps
    end
  end
end
