class AddEvaluationToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :rate, :float
  end
end
