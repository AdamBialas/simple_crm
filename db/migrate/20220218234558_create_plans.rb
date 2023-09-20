class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.date :event_date
      t.string :event_name
      t.text :event_description
      t.integer :status
      t.integer :event_type
      t.integer :company_id
      t.integer :user_id  
      t.integer :contact_id
      t.integer :address_id 

      t.timestamps
    end
  end
end
