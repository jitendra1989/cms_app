class CreateMgNatureOfDocuments < ActiveRecord::Migration
  def change
    create_table :mg_nature_of_documents do |t|
      t.string :name
      t.text :description
      t.text :extention
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
