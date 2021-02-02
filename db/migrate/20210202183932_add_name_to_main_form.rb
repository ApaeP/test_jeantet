class AddNameToMainForm < ActiveRecord::Migration[6.0]
  def change
    add_column :main_forms, :name, :string, default: ''
  end
end
