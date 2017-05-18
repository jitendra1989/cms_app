class CreateMgInvigilators < ActiveRecord::Migration
  def change
    create_table :mg_invigilators do |t|
      t.date :date
      t.time :time
      t.integer :mg_subject_id
      t.integer :no_of_invigilators
      t.text :description

      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
