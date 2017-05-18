class CreateMgPlacementTrainingOffereds < ActiveRecord::Migration
  def change
    create_table :mg_placement_training_offereds do |t|
      t.integer :mg_placement_registration_id
      t.text :area_of_training
      t.date :start_date
      t.date :end_date
      t.integer :mg_school_id
      t.boolean :is_deleted
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
