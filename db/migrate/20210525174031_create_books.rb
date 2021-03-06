class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.date :publish_date
      t.string :description
      t.text :content

      t.timestamps
    end
  end
end
