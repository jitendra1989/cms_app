class CreateMgExaminationTimeTables < ActiveRecord::Migration
  def change
    create_table :mg_examination_time_tables do |t|
      t.integer :mg_examination_detail_id
      t.integer :mg_subject_id
      t.date :date
      t.time :start_time
      t.time :end_time
      t.decimal :max_marks
      t.decimal :pass_marks
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
