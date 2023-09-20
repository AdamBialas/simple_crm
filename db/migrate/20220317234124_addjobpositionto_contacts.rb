class AddjobpositiontoContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :jobposition, :string
  end
end
