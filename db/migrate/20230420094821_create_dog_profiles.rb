class CreateDogProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :dog_profiles do |t|
      t.string :dog_breed
      t.string :dog_number
      t.date   :dog_birthday
      t.text   :dog_profile
      t.references :user,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
