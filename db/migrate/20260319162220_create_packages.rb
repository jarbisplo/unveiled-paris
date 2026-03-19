class CreatePackages < ActiveRecord::Migration[8.1]
  def change
    create_table :packages do |t|
      t.string :name
      t.string :slug
      t.string :tagline
      t.text :description
      t.integer :price_cents
      t.string :duration
      t.string :stripe_price_id

      t.timestamps
    end
  end
end
