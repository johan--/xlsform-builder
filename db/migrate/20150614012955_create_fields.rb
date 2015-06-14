class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.text :odk_type
      t.text :name
      t.text :label
      t.integer :form_id

      t.timestamps null: false
    end
  end
end
