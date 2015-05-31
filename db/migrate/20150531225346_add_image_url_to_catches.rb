class AddImageUrlToCatches < ActiveRecord::Migration
  def change
    add_attachment :catches, :image
  end
end
