

class DocumentsController <  ApplicationController
    def index
        @user=current_user
        @documents=@user.documents
        @document=  Document.new
        @loans=Loan.all.select{|loan|  loan.friend.id== @user.id };
        #@keys=@loans.collect{|loan|  loan.key };

    end

    def create
      @user=current_user
      @document = Document.new
      @document.key=Key.find(params[:document][:key_id])
      key=rsa_decrypt(get_private_key,@document.key.value)

      docu_name=params[:document][:upload].original_filename
      # delete  if  exist
=begin
      docu_copi=Document.find_by_name(aes_encrypt(get_super_key,docu_name))
      if docu_copi
        path_copi=aes_decrypt(key,docu_copi.path)
        File.delete(path_copi)
        docu_copi.destroy
      end
      #delete if exist
=end
      docu_owner=@user.name
      if Document.maximum(:id)
          docu_last_index= Document.maximum(:id)+1
      else
          docu_last_index=0
      end
      path="public/data/#{ (aes_encrypt(key,"#{docu_last_index}")).tr('/','')}"
      @document.user=@user
      @document.name=aes_encrypt(key,docu_name);
      @document.path=aes_encrypt(key,path)
      @document.remark=aes_encrypt(key,params[:document][:remark])  if params[:document][:remark] && params[:document][:remark]!=""
      if  @document.save
        if File.exist?(path)
          File.delete(path)
        end
          File.open(path, "wb") { |f| f.write(aes_pain_encrypt(key,params[:document][:upload].read)) }####################
      end
      #render :json=> @document
      redirect_to "/documents"
    end

    def  destroy
      document=Document.find(params[:id])
      path_encrypated= document.path
      key=rsa_decrypt(get_private_key, document.key.value)
      path=aes_decrypt(key,path_encrypated)
      File.delete(path)
      Document.destroy(params[:id])
      redirect_to "/documents"
    end

    def get_encrypted_document
       document=Document.find(params[:id])
       key=rsa_decrypt(get_private_key,document.key.value)
       file_path=aes_decrypt(key,document.path)
       file_name=aes_decrypt(key,document.name)
       file_data=File.read(file_path)
       send_data file_data, :filename=> file_name #, :disposition=> 'inline'


    end

    def  get_decrypted_document
       document=Document.find(params[:id])
       key=rsa_decrypt(get_private_key,document.key.value)
       file_path=aes_decrypt(key,document.path)
       file_name=aes_decrypt(key,document.name)
       file_data=aes_pain_decrypt(key,File.read(file_path))
       #render :text => key
       send_data file_data, :filename=> file_name #, :disposition=> 'inline'

    end

    def   crypt_with_key
     #key_id=params[:document][:key_id]
     #key_obj=Key.find(key_id)
     key=rsa_decrypt(get_private_key,Loan.find(params[:loan_id]).key_value)
     file_name=params[:upload].original_filename
     file_data=aes_pain_decrypt(key,params[:upload].read)
     #file_data=params[:document][:upload].read
     #File.open("public/#{file_name}", "wb"){|f| f.write(file_data)}
     #file_data=aes_pain_decrypt(key,File.read("public/#{file_name}"))
     #File.delete("public/#{file_name}");
     #render :text => key
     send_data file_data, :filename=> file_name#, :disposition=> 'inline'


    end




end