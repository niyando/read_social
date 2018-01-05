class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, null: false, index:true
      t.string :token, null: false
      t.string :token_secret, null: false
      t.timestamps
    end
  end
end
