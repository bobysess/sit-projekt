

class DocumentsController <  ApplicationController
    def index
        @user=current_user
        @documents=@user.documents
        @document=  Document.new
        loans=Loan.all.select{|loan|  loan.friend.id== @user.id };
        @keys=loans.collect{|loan|  loan.key };

    end

    def create
      @user=current_user
      @document = Document.new
      docu_name=params[:document][:upload].original_filename
      # delete  if  exist
      docu_copi=Document.find_by_name(aes_encrypt(get_super_key,docu_name))
      if docu_copi
        path_copi=aes_decrypt(get_super_key,docu_copi.path)
        File.delete(path_copi)
        docu_copi.destroy
      end
      #delete if exist
      docu_owner=@user.name
      docu_id=@document.id
      path="public/data/#{ aes_encrypt(get_super_key,"#{docu_name}")}"
      @document.user=@user
      @document.name=aes_encrypt(get_super_key,docu_name);
      @document.path=aes_encrypt(get_super_key,path)
      @document.key=Key.find(params[:document][:key_id])
      key=aes_encrypt(get_super_key,@document.key.value)
      @document.remark=aes_encrypt(get_super_key,params[:document][:remark])  if params[:document][:remark] && params[:document][:remark]!=""
      if  @document.save
          File.open(path, "wb") { |f| f.write(aes_pain_encrypt(key,params[:document][:upload].read)) }####################
      end
      #render :json=> @document
      redirect_to "/documents"
    end

    def  destroy
      path_encrypated= Document.find(params[:id]).path
      path=aes_decrypt(get_super_key,path_encrypated)
      File.delete(path)
      Document.destroy(params[:id])
      redirect_to "/documents"
    end

    def get_encrypted_document
       document=Document.find(params[:id])
       file_path=aes_decrypt(get_super_key,document.path)
       file_name=aes_decrypt(get_super_key,document.name)
       file_data=File.read(file_path)
       send_data file_data, :filename=> file_name#, :disposition=> 'inline'


    end

    def  get_decrypted_document
       document=Document.find(params[:id])
       key=aes_encrypt(get_super_key,document.key.value)
       file_path=aes_decrypt(get_super_key,document.path)
       file_name=aes_decrypt(get_super_key,document.name)
       file_data=aes_pain_decrypt(key,File.read(file_path))
       send_data file_data, :filename=> file_name#, :disposition=> 'inline'

    end

    def   crypt_with_key
     key_id=params[:document][:key_id]
     key_obj=Key.find(key_id)
     key=aes_decrypt(key_obj.user.get_super_key,key_obj.value)
     file_name=params[:document][:upload].original_filename
     file_data=aes_pain_decrypt(key,params[:document][:upload].read)
     file_data=params[:document][:upload].read
     #buf=params[:document][:upload].read
     #render :text => buf

      send_data file_data, :filename=> file_name, :disposition=> 'inline'


    end




end