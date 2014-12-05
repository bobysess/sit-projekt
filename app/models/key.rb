class Key< ActiveRecord::Base

     belongs_to :user
     has_many   :documents,dependent: :destroy
     has_many   :loans, :dependent => :destroy
     #has_many   :distributed_documents, :dependent => :destroy


end