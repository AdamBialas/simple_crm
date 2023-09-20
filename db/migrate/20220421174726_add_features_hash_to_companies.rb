class AddFeaturesHashToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :features_hash, :string
  end
end
