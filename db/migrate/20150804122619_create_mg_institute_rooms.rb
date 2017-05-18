class CreateMgInstituteRooms < ActiveRecord::Migration
  def change
    create_table :mg_institute_rooms do |t|
      t.string :room_no
      t.integer :mg_employee_specialization_id
      t.integer :capacity
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
