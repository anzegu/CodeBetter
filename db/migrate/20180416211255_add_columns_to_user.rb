class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :problems, :input1, :string
    add_column :problems, :output1, :string
    add_column :problems, :input2, :string
    add_column :problems, :output2, :string
  end
end
