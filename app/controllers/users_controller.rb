class UsersController< ApplicationController
  skip_before_action :require_login
  before_action :check_input, :only => :create

  def new
    if current_user.nil?
       @user= User.new
    else
      redirect_to "/documents"
    end
  end

  def create
     #password_hash=hash(params[:user][:password])
     if(params[:user][:password]==params[:user][:confirm_password] && params[:user][:super_key]== params[:user][:super_key_confirm])
       # hash password und save
       #save the others  encoded
       @user=User.new
       @user.email= params[:user][:email]
       @user.name=params[:user][:name]
      # @user.password=password_hash
       @user.password = params[:user][:password]
       #@user.confirm_password=password_hash


       ## save super password
       @user.super_key=hash(hash(params[:user][:super_key]))
       ##generate key_pair
       key_pair= generate_key_pair
       private_key=key_pair[:private_key]
       public_key=key_pair[:public_key]
       @user.key_public=public_key
       @user.key_private=aes_encrypt(hash(params[:user][:super_key]),private_key)
       if @user.save!
          session[:user_id]=@user.id
          session[:super_key]=hash(params[:user][:super_key])
          redirect_to "/documents";
       else
          redirect_to "/registration"
       end
     else
       flash[:notice] = "Confirm password  or confirm superkey is uncorrect!"
       redirect_to "/registration"
     end
  end


  def check_input
     if  params[:user][:name]==""
        flash[:error]= "Please enter a Username"
        redirect_to "/registration"
     elsif params[:user][:email]==""
       flash[:error]= "Please enter a Email"
       redirect_to "/registration"
     elsif params[:user][:password]==""
       flash[:error]= "Please enter a Password"
       redirect_to "/registration"
     elsif params[:user][:super_key]==""
       flash[:error]= "Please enter a Superkey"
       redirect_to "/registration"
     end

  end


end