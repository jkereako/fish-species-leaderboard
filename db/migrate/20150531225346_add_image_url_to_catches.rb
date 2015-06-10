class AddImageUrlToCatches < ActiveRecord::Migration
  def change
    add_attachment :catches, :image
    add_column :catches, :image_fingerprint, :string, default: '', null: false
  end
end
