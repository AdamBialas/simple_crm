class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :country
      t.string :street
      t.string :number
      t.string :city
      t.string :region
      t.string :postcode
      t.integer :status
      t.boolean :main      
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
