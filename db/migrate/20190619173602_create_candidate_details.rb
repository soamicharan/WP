class CreateCandidateDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :candidate_details do |t|
      t.integer :s_no
      t.string :src_reg
      t.string :zone
      t.date :DOR
      t.string :reg_no
      t.string :name
      t.string :gender
      t.integer :age
      t.text :address
      t.string :branch
      t.string :email
      t.integer :contact_no
      t.string :state
      t.string :qualification
      t.string :specialization
      t.string :experience
      t.integer :remarks_mobility
      t.date :DOC
      t.string :status

      t.timestamps
    end
    add_index :candidate_details, :s_no, unique: true
    add_index :candidate_details, :email, unique: true
    add_index :candidate_details, :contact_no, unique: true
  end
end
