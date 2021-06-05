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

  def search 
    if params[:friend].present?
      @friends = Friendship.new_lookup(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if !@friends.empty?
        respond_to do |format| 
          format.js { render partial: 'friendships/result'}
        end
      else 
        respond_to do |format| 
          flash.now[:alert] = "Couldn't find user" 
          format.js { render partial: 'friendships/result'}
        end
      end
    else
      respond_to do |format| 
        flash.now[:alert] = "Please enter a name or email to search" 
        format.js { render partial: 'friendships/result'}
      end
    end
  end

  def create 
    friend = User.find(params[:friend_id])
    @friendship = Friendship.create(user:current_user, friend: friend)
    flash[:notice] = "User #{friend.email} was successfully followed"
    redirect_to my_friends_path
  end

end