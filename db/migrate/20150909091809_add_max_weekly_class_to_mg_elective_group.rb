class AddMaxWeeklyClassToMgElectiveGroup < ActiveRecord::Migration
  def change
    add_column :mg_elective_groups, :max_weekly_class, :integer
  end
end
