class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password

      t.timestamps
    end
    add_index :admins, :email, unique: true
  end
end
