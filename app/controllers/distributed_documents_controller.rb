class DistributedDocumentsController < ApplicationController
  def  index
    @user=current_user
    @docus_from_user=DistributedDocument.all.select{|docu| docu.user.id==@user.id}
    @docus_to_user=DistributedDocument.all.select{|docu| docu.friend.id==@user.id}
    @friends=@user.friends
    @docus=@user.documents
    @document =DistributedDocument.new
  end

  def  destroy
    DistributedDocument.destroy(params[:id])
    #render html: "super".html_safe
    #render :text => "super", :layout => false
    #render nothing: true
    redirect_to  distributed_documents_path
  end

  def  create
    @user=current_user
    @docu= DistributedDocument.new
    if((DistributedDocument.select{|docu|  (docu.document.id==params[:distributed_document][:document_id].to_i  && docu.friend_id==params[:distributed_document][:friend_id].to_i && docu.user_id==@user.id) }).count==0 ) # schon vorhanden
      @docu.user=@user
      @docu.friend=User.find(params[:distributed_document][:friend_id])
      @docu.document=Document.find(params[:distributed_document][:document_id])
      key=rsa_decrypt(get_private_key, @docu.document.key.value)
      @docu.key=rsa_encrypt(@docu.friend.key_public,key )  # zu bearbeiten
      @docu.save
    else

    end
    redirect_to distributed_documents_path
    #end

  end

  def show
    document=DistributedDocument.find(params[:id])
    key=rsa_decrypt(get_private_key,document.key)
    file_path=aes_decrypt(key,document.document.path)
    file_name=aes_decrypt(key,document.document.name)
    file_data=aes_pain_decrypt(key,File.read(file_path))
    #render :text => key
    send_data file_data, :filename=> file_name #, :disposition=> 'inline'
  end

end