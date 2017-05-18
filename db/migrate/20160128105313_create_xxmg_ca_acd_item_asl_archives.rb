class CreateXxmgCaAcdItemAslArchives < ActiveRecord::Migration
  def change
    create_table :xxmg_ca_acd_item_asl_archives do |t|
      t.string :action
      t.string :ewie_item
      t.string :plant_code
      t.string :supplier
      t.string :supplier_site
      t.string :supplier_item
      t.string :purchase_uom
      t.string :record_status
      t.text :error_messages
      t.integer :request_id
      t.integer :last_update_login
      t.date :last_update_date
      t.integer :last_updated_by
      t.integer :created_by
      t.integer :updated_by
      t.date :creation_date

      t.timestamps
    end
  end
end
