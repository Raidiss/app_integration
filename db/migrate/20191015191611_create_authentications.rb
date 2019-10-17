class CreateAuthentications < ActiveRecord::Migration[6.0]
  def change
    create_table :authentications do |t|
      t.string :access_token
      t.integer :expires_in
      t.string :restricted_to
      t.string :token_type
      t.string :refresh_token

      t.timestamps
    end
  end
end
