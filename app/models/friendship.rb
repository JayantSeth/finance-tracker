class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.new_lookup(friend_data) 
    the_friends = User.where("email like ?", "%#{friend_data}%")
    if the_friends.empty? 
      the_friends = User.where("first_name like ?", "%#{friend_data}%")
      if the_friends.empty? 
        the_friends = User.where("last_name like ?", "%#{friend_data}%")
      end
    end
    the_friends
  end

end
