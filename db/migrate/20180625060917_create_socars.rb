class CreateSocars < ActiveRecord::Migration[5.0]
  def change
    create_table :socars do |t|
      t.string :title
      t.text :contents

      t.timestamps
    end
  end
end
