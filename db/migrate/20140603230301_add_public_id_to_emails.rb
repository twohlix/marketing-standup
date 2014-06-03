class AddPublicIdToEmails < ActiveRecord::Migration
  def up
    change_table :emails do |t|
      t.string :public_id, null: false, default: '', index: :unique
    end
  end

  def down
    remove_column :emails, :public_id
  end
end
