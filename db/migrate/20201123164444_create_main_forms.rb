class CreateMainForms < ActiveRecord::Migration[6.0]
  def change
    create_table :main_forms do |t|
      t.string :answers
      t.timestamps
    end
  end
end
