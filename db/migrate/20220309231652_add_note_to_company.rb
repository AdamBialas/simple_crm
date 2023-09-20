class AddNoteToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :note, :string
  end
end
