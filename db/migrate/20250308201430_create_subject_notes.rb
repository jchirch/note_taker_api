class CreateSubjectNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :subject_notes do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end
  end
end
