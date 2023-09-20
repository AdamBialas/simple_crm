class AddownToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :own, :boolean,null: false, default: false
  end
end
