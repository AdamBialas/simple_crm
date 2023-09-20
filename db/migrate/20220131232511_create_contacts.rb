class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :lastname
      t.references :company, null: false, foreign_key: true
      t.string :email
      t.string :phone
      t.datetime :last_event
      t.integer :status

      t.timestamps
    end
  end
end
