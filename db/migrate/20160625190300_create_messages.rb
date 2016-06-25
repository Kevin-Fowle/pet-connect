class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :body
      t.references :user
      t.references :pairing

      t.timestamps null: false
    end
  end
end
