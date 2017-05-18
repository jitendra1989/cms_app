class CreateMgCurriculumGrades < ActiveRecord::Migration
  def change
    create_table :mg_curriculum_grades do |t|
      t.string :grade_name
      t.text :description
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
