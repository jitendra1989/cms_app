class CreateMgElectiveTypes < ActiveRecord::Migration
  def change
    create_table :mg_elective_types do |t|
      t.string :name
      t.string :description
      t.integer :mg_school_id
      t.boolean :is_deleted
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
