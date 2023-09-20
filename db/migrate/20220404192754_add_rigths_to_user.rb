class AddRigthsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :rights, :string
  end
end
