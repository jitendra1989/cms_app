class CreateMgExamSeatingPlans < ActiveRecord::Migration
  def change
    create_table :mg_exam_seating_plans do |t|
      t.integer :mg_examination_detail_id
      t.integer :mg_employee_specialization_id
      t.integer :mg_institute_room_id
      t.integer :total_seats
      t.integer :seat_available

      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by	
      t.timestamps
    end
  end
end
