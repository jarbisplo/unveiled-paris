class CreateSiteConfigs < ActiveRecord::Migration[8.1]
  def change
    create_table :site_configs do |t|
      t.string :key
      t.text :value

      t.timestamps
    end
    add_index :site_configs, :key
  end
end
