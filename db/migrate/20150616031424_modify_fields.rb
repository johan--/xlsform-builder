class ModifyFields < ActiveRecord::Migration
  def change
    add_column :fields, :index, :integer
  end
end
