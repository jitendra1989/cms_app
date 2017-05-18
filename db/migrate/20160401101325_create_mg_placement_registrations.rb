class CreateMgPlacementRegistrations < ActiveRecord::Migration
  def change
    create_table :mg_placement_registrations do |t|
    	t.string :name_of_the_company
    	t.string :industry
    	t.string :company_website_url
    	t.string :location
    	t.text :address
    	t.string :contact_email
    	t.string :contact_number
    	t.string :contact_person
    	t.boolean :is_alumni
    	t.boolean :have_alumni_id
      t.string :alumni_id
      t.string :is_approved

    	t.integer :mg_school_id
      	t.integer :created_by
      	t.integer :updated_by
      	t.boolean :is_deleted
      	t.timestamps
    end
  end
end
