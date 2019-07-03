class ChangePhoneType < ActiveRecord::Migration[5.2]
  def change
    change_column :candidate_details, :contact_no , :string
  end
end
