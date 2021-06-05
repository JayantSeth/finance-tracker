class FriendshipsController < ApplicationController 
  def my_friends 
    @friends = current_user.friends
  end

  def destroy 
    the_friend = User.find(params[:id])
    friendship = Friendship.where(user_id: current_user.id, friend_id: params[:id]).first 
    friendship.destroy 
    flash[:notice] = "#{the_friend.email} was successfully unfollowed"
    redirect_to my_friends_path
  end

end