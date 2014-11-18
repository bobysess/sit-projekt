class UsersController< ApplicationController
  skip_before_action :require_login

  def new
    if current_user.nil?
       @user= User.new
    else
      redirect_to "/documents"
    end
  end

  def create
     password_hash=hash(params[:user][:password])
     if(params[:user][:password]==params[:user][:confirm_password])
       # hash password und save
       #save the others  encoded
       @user=User.new
       @user.password=password_hash
       @user.confirm_password=password_hash
       @user.email= aes_encrypt(password_hash,params[:user][:email])
       @user.name=aes_encrypt(password_hash,params[:user][:name])
       if @user.save
          session[:user_id]=@user.id
          redirect_to "/documents";
       else
          redirect_to "/registration"
       end
     else
       redirect_to "/registration"
     end
  end


end