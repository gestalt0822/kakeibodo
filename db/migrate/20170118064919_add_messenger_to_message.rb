class AddMessengerToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :messenger, :string
  end
end
