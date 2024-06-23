class AddDeletedAtToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :deleted_at, :datetime, null: true
  end

  def down
   remove_column :users, :deleted_at
  end

end


