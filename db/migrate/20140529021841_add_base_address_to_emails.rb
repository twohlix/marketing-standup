class AddBaseAddressToEmails < ActiveRecord::Migration
  def up
    change_table :emails do |t|
      t.string :base_address, null: false, default: '', index: :unique
    end
  end

  def down
    remove_column :emails, :base_address    
  end
end
