class RemoveLanguageIdFromProblems < ActiveRecord::Migration[5.1]
  def change
    remove_column :problems, :language_id, :integer
  end
end
