class RemoveColumnsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :dog_breed, :string
    remove_column :users, :dog_birthday, :date
    remove_column :users, :dog_profile, :text
  end
end
