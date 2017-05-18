class ChangeStringTypeToText < ActiveRecord::Migration
  def change
  	change_column :mg_elective_types, :description, :text
  	change_column :mg_elective_groups, :description, :text
  end
end
