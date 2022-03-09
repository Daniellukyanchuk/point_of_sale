class AddForeignKeyToUploads < ActiveRecord::Migration[5.2]
  def change
    add_column :uploads, :active_storage_attachment_id, :integer
  end
end
