class AddTokenIdToAuthentication < ActiveRecord::Migration[6.0]
  def change
    add_column :authentications, :token_id, :bigint
  end
end
