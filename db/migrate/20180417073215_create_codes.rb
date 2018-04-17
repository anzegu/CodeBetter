class CreateCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :codes do |t|
      t.references :language, foreign_key: true
      t.references :problem, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
