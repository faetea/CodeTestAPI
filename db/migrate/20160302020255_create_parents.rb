class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :name
    end
  end
end
