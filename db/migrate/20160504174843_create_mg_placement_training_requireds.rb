class CreateMgPlacementTrainingRequireds < ActiveRecord::Migration
  def change
    create_table :mg_placement_training_requireds do |t|
      t.string :area_of_training_required
      t.text :description
      t.string :status
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
