class KeyPairsController < ApplicationController

   def  index
     @user=current_user
     @key_pairs=@user.key_pairs
   end

   def create
    @user=current_user
    key_pair=generate_key_pair
    @key_pair=KeyPair.new
    @key_pair.user=@user
    @key_pair.remark=aes_encrypt(get_super_key,params[:remark])
    @key_pair.privat_key=aes_encrypt(get_super_key,key_pair[:private_key])
    @key_pair.public_key=aes_encrypt(get_super_key,key_pair[:public_key])
    @key_pair.save

    redirect_to key_pairs_path

   end

   def destroy
     KeyPair.destroy(params[:id])
     redirect_to key_pairs_path

   end

   def private_key
     key_pair=KeyPair.find(params[:id])
     private_key= aes_decrypt(get_super_key,key_pair.privat_key)
     render :text=> private_key
   end

   def public_key
     key_pair=KeyPair.find(params[:id])
     public_key= aes_decrypt(get_super_key,key_pair.public_key)
     render :text=> public_key
   end


end