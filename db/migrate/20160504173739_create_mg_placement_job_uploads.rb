class CreateMgPlacementJobUploads < ActiveRecord::Migration
  def change
    create_table :mg_placement_job_uploads do |t|
      t.string :position
      t.text :job_description
      t.string :functional_area
      t.string :industry
      t.string :job_location
      t.string :edu_qual
      t.integer :min_exp
      t.text :technical_skills
      t.text :soft_skills
      t.integer :salary
      t.string :company
      t.string :company_website
      t.string :job_id
      t.string :rel_exp
      t.string :referral_code
      t.date :last_date_application
      t.date :interview_date
      t.text :interview_location
      t.string :status
      t.integer :round1
      t.integer :round2
      t.integer :round3
      t.integer :round4
      t.integer :round5
      t.integer :round6
      t.integer :round7
      t.integer :round8
      t.integer :round9
      t.integer :round10
      t.integer :created_by
      t.integer :updated_by
      t.boolean :is_deleted
      t.integer :mg_school_id

      t.timestamps
    end
  end
end
