

class  User <  ActiveRecord::Base

      #has_many :friends ,:through => :friendships
      has_many :keys
      has_many :documents
     # belongs_to :users
      has_many :loans
      has_many :key_pairs

      #has_and_belongs_to_many :users
      #has_and_belongs_to_many :friends, class_name:  "User"
      #has_and_belongs_to_many :users


      validates :email , :presence =>true, :uniqueness => true
      validates :password , :presence =>true
      validates :confirm_password , :presence =>true
      validates :name , :presence =>true , :uniqueness => true

      def get_super_key
         self.password
      end

      def  friends
          friendships=Friendship.all.select{|fr|  fr.user.id==self.id}
          friends=friendships.collect{|fr| fr.friend}
          friends
      end
end