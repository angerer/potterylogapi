class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|      
      t.string :project
      t.string :general_notes
      t.string :surface_notes
      t.decimal :height
      t.decimal :diameter
      t.decimal :width
      t.decimal :length
      t.string :units
      t.string :status
      t.decimal :price
      t.string :worktype
      t.string :material
      t.string :created_by
      
      t.timestamps
    end
  end
end
