class AddIshodandisdeanandhodspecializationidToMgEmployee < ActiveRecord::Migration
  def change
    add_column :mg_employees, :is_hod, :boolean
    add_column :mg_employees, :is_dean, :boolean
    add_column :mg_employees, :hod_specialization_id, :integer
  end
end
