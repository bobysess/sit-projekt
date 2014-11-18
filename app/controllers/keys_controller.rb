class KeysController < ApplicationController

  def  index
      @user=current_user
      @keys=@user.keys
  end

  def  destroy
     Key.destroy(params[:id])
     #render html: "super".html_safe
     redirect_to "/keys"
  end

  def  create
     key=generate_key
     @key= Key.new
     @key.value=aes_encrypt(get_super_key,key)
     @key.remark=aes_encrypt(get_super_key,params[:remark]) unless params[:remark].empty?
     @key.user=current_user
     if @key.save
     else
     end

    redirect_to "/keys"

  end


end