class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.string :uuid
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email, unique: true
      t.timestamps
    end
  end
end
