class AddIsFeeApplicableToMgEvents < ActiveRecord::Migration
  def change
    add_column :mg_events, :is_fee_applicable, :boolean
    add_column :mg_events, :amount, :float

  end
end
