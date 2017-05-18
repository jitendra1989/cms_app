class AddMgEmployeeIdToMgUnit < ActiveRecord::Migration
  def change
    add_column :mg_units, :mg_employee_id, :integer
  end
end
