class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :zip_code
      t.string :state
      t.string :website

      t.timestamps null: false
    end
  end
end
