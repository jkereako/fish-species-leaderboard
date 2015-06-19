class ChangeLengthInInchesFromIntegerToFloat < ActiveRecord::Migration
  def change
    change_column :catches, :length_in_inches, :float
  end
end
