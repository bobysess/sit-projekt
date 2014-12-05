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
     #password_hash=hash(params[:user][:password])
     @user=User.find_by_email(params[:user][:email])


     if  @user
       #if((@user.password==password_hash) && (@user.test_pass_encrypt=aes_encrypt(hash(params[:user][:super_key]),@user.test_pass_plain)))
       #if((@user.password==password_hash))
       if @user.password == params[:user][:password] && hash(hash(params[:user][:super_key]))== @user.super_key
          session[:user_id]=@user.id
          session[:super_key]=hash(params[:user][:super_key])
          redirect_to "/documents"
       else
         flash[:error] = "Password or Superkey is uncorrect!"
         redirect_to "/login"
       end
     else
         flash[:error] = "This User is don't Exist!"
         redirect_to "/login"
     end

   end

   def destroy
     session[:user_id]=nil
     session[:super_key]=nil
     redirect_to "/login"

   end
end