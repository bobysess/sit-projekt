class LoansController < ApplicationController

  def  index
    @user=current_user
    @loans_to_user=Loan.all.select{|loa| loa.friend.id==@user.id}
    @loans_from_user=Loan.all.select{|loa| loa.user.id==@user.id}
    @friends=@user.friends
    @keys=@user.keys
    @loan =Loan.new
  end

  def  destroy
    Loan.destroy(params[:id])
    #render html: "super".html_safe
    #render :text => "super", :layout => false
    #render nothing: true
    redirect_to "/loans"
  end

  def  create
    @user=current_user
    @loan= Loan.new
    if((Loan.select{|loan|  (loan.key_id==params[:loan][:key_id].to_i  && loan.friend_id==params[:loan][:friend_id].to_i && loan.user_id==@user.id) }).count==0 ) # schon vorhanden
      @loan.user=@user
      @loan.friend=User.find(params[:loan][:friend_id])
      @loan.key=Key.find(params[:loan][:key_id])
      public_key=@loan.friend.key_public
      key=rsa_decrypt(get_private_key,@loan.key.value)
      @loan.key_value=rsa_encrypt(public_key,key)
      if @loan.key.remark
         remark=rsa_decrypt(get_private_key,@loan.key.remark)
         @loan.remark=rsa_encrypt(public_key,remark)
      end
      @loan.save
    else

    end
    redirect_to loans_path
    #end
=begin
      respond={:key=>"#{aes_decrypt(get_super_key,@loan.key.value)} #{aes_decrypt(get_super_key,@loan.key.remark)}",
               :friend=>"#{aes_decrypt(@loan.friend.get_super_key,@loan.friend.name)}}",
               :user=>"#{aes_decrypt(@loan.user.get_super_key,@loan.user.name)}",
               :id=>@loan.id}
      render json:  respond
=end
     # render  "index"
    # else
     # render html: "error".html_safe
    #end

  end


end