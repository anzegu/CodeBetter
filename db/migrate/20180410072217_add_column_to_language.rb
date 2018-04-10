class AddColumnToLanguage < ActiveRecord::Migration[5.1]
  def change
    add_column :languages, :name, :string
    add_column :languages, :judgeid, :integer
    add_column :languages, :acename, :string
  end
end
