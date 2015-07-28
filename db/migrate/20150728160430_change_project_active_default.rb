class ChangeProjectActiveDefault < ActiveRecord::Migration
  def change
    change_column_default :projects, :active, true
  end
end