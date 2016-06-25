class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message
      t.text :body
      t.references :conversation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
