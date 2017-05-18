class AddTimeAllotedToMgTopic < ActiveRecord::Migration
  def change
    add_column :mg_topics, :time_alloted, :integer
  end
end
