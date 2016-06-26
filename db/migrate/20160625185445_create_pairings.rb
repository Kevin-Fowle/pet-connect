class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.boolean :org_approved, default: false
      t.boolean :active, default: false
      t.references :user
      t.references :organization

      t.timestamps null: false
    end
  end
end
