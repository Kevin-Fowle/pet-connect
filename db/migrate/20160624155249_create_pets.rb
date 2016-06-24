class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :species
      t.string :breed
      t.integer :weight
      t.text :description
      t.references :user

      t.timestamps null: false
    end
  end
end
