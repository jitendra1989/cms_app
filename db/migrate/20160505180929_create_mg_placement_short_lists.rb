class CreateMgPlacementShortLists < ActiveRecord::Migration
  def change
    create_table :mg_placement_short_lists do |t|
      t.integer :mg_student_id
      t.date :interview_selected_date
      t.boolean :is_round_selected
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
