class CreateMgEmployeeHodLogins < ActiveRecord::Migration
  def change
    create_table :mg_employee_hod_logins do |t|
      t.integer :mg_user_id
      t.integer :mg_employee_id
      t.integer :mg_school_id
      t.boolean :is_deleted
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
