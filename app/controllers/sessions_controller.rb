class SessionsController<ApplicationController
   skip_before_action :require_login

   def new
     if current_user.nil?
       @user= User.new
     else
       redirect_to "/documents"
     end

   end
   def  create
     @user =User.new
     password_hash=hash(params[:user][:password])
     @user=User.find_by_email(aes_encrypt(password_hash, params[:user][:email]))
     if  @user
       if(@user.password==password_hash)
          session[:user_id]=@user.id
          redirect_to "/documents"
       else
         redirect_to "/login"
       end
     else
         redirect_to "/login"
     end

   end

   def destroy
     session[:user_id]=nil
     redirect_to "/login"

   end
end