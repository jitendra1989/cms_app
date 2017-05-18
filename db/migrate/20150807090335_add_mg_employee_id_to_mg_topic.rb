class AddMgEmployeeIdToMgTopic < ActiveRecord::Migration
  def change
    add_column :mg_topics, :mg_employee_id, :integer
  end
end
