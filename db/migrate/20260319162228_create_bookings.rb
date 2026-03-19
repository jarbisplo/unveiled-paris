class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.date :tour_date
      t.integer :group_size
      t.references :package, null: false, foreign_key: true
      t.text :special_requests
      t.integer :status, default: 0
      t.string :stripe_session_id
      t.integer :amount_paid_cents

      t.timestamps
    end
  end
end
