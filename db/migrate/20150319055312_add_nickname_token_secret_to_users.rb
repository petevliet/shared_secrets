class AddNicknameTokenSecretToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :user_token, :string
    add_column :users, :user_token_secret, :string
  end
end
