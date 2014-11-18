class Key< ActiveRecord::Base

     belongs_to :user
     has_many   :documents
     has_many   :loans


end