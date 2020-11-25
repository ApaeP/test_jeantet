class CreateFormSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :form_steps do |t|
      t.integer :number
      t.string :answer
      t.references :main_form, null: false, foreign_key: true

      t.timestamps
    end
  end
end
