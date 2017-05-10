class DropProjectId < ActiveRecord::Migration[5.1]
  def change
    remove_column(:employees, :project_id, :integer)
  end
end
