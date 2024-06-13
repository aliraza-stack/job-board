class CreateUserDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :user_details do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :profession
      t.text :bio
      t.date :birthday
      t.string :gender, default: 'male'
      t.string :phone_number
      t.string :website

      t.timestamps
    end
  end
end
