class FriendsController < ApplicationController
  def  index
    @friend=User.new
    @user=current_user
    @friends=@user.friends
    other_users=User.all
   #other_users.delete(@user)
    @other_users=other_users
    @other_users.delete_if{|u|  u.id==@user.id}
    @friends.each{|fr| @other_users.delete_if{|u|  u.id==fr.id} }
  end

  def  destroy
    @user=current_user
    @friend= User.find(params[:id])
    friendships=Friendship.all.select{|fr|  (fr.user.id==@user.id && fr.friend.id==@friend.id)}
    Friendship.destroy(friendships.first) ## get only one object
    redirect_to "/friends"
  end

  def   create
     @user=current_user
     @friend= (User.all.select{|u| u.name== params[:friend_name]}).first if params[:friend_name] && params[:friend_name]!=""
     @friend= User.find(params[:friend_id]) if params[:friend_id]
     #check if the  user exists
     unless @friend && params[:friend_name] && params[:friend_name]==""
         flash[:error] = "This User is don't Exist!"
     end
     @friendship=Friendship.new
    if !@user.friends.include?(@friend) && @friend
       @friendship.user=@user
       @friendship.friend=@friend
       @friendship.save
    end
    redirect_to "/friends"

  end
end