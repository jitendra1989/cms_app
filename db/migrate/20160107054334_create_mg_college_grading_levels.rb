class CreateMgCollegeGradingLevels < ActiveRecord::Migration
  def change
    create_table :mg_college_grading_levels do |t|
      t.string :name
      t.integer :mg_batch_id
      t.integer :mg_course_id
      t.float :min_score
      t.string :credit_points
      t.text :description
      t.integer :mg_school_id
      t.integer :is_deleted
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
