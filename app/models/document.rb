class Document< ActiveRecord::Base

    #before_destroy :delete_file
    belongs_to :key
    belongs_to :user
    has_many :distributed_documents, dependent: :destroy
=begin
    def delete_file
      private_key =aes_decrypt(session[:super_key] ,self.user.key_private)
      path_encrypated= self.path
      key=rsa_decrypt(private_key, self.key.value)
      path=aes_decrypt(key,path_encrypated)
      File.delete(path)
      Document.destroy(self.id)
    end
=end
end