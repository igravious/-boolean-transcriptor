class RenameSubjectToIndexTerm < ActiveRecord::Migration
  def change
      rename_column :headings, :subject, :index_term
  end
end
