class RenameFriendsToFriendships < ActiveRecord::Migration[5.1]
  def change
    def self.up
        rename_table :friends, :friendships
      end

      def self.down
        rename_table :friendships, :friends
      end
  end
end
