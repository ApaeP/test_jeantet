class AddSlugToMainForms < ActiveRecord::Migration[6.0]
  def change
    add_column :main_forms, :slug, :string
    add_index :main_forms, :slug, unique: true
  end
end
