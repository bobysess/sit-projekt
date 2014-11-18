class KeyPair <  ActiveRecord::Base
   belongs_to :user

   validates :remark, :presence => true

end