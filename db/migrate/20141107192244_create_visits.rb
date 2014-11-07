class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :user, null: false
      t.string :country_id, null: false

      t.timestamps
    end
    add_index :visits, :user_id
    add_index :visits, :country_id
  end
end
