class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.string :uuid
      t.string :reservation_code, unique: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :nights
      t.integer :guests
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.integer :status
      t.string :currency
      t.float :payout_price
      t.float :security_price
      t.float :total_price
      t.references :guest, foreign_key: true
      t.timestamps
    end

    add_index :reservations, [:reservation_code], unique: true
  end
end
