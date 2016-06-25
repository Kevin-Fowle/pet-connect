class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.boolean :approved
      t.references :user, index: true, foreign_key: true
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
