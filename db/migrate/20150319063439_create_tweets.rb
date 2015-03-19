class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_text
      t.belongs_to :user, index: true
    end
    add_foreign_key :tweets, :users
  end
end
