class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.boolean :approved
      t.references :user
      t.references :organization

      t.timestamps null: false
    end
  end
end
