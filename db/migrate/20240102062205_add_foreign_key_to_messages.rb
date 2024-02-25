class AddForeignKeyToMessages < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :messages, :users, column: :sender_id, column: :recipient_id, on_update: :cascade, on_delete: :cascade
  end
end
