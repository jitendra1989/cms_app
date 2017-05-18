class CreateMgExaminationHodLogins < ActiveRecord::Migration
  def change
    create_table :mg_examination_hod_logins do |t|
      t.integer :mg_employee_specialization_id
      t.integer :mg_user_id
      t.integer :created_by
      t.integer :updated_by
      t.integer :mg_school_id
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
