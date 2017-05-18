class CreateMgExaminationEvaluations < ActiveRecord::Migration
  def change
    create_table :mg_examination_evaluations do |t|
      t.integer :mg_examination_detail_id
      t.date :date_of_evaluation
      t.integer :created_by
      t.integer :updated_by
      t.integer :mg_school_id
      t.integer :is_deleted

      t.timestamps
    end
  end
end
