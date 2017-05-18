class CreateMgExamTypes < ActiveRecord::Migration
  def change
    create_table :mg_exam_types do |t|
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
