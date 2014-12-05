require 'bcrypt'
class  User <  ActiveRecord::Base
  include BCrypt


  #has_many :friends ,:through => :friendships
      has_many :keys ,dependent: :destroy
      has_many :documents,dependent: :destroy
     # belongs_to :users
      has_many :loans ,dependent: :destroy
      has_many :key_pairs ,dependent: :destroy
      has_many :Friendships ,dependent: :destroy
      has_many :distributed_documents, dependent: :destroy

      #has_and_belongs_to_many :users
      #has_and_belongs_to_many :friends, class_name:  "User"
      #has_and_belongs_to_many :users


      validates :email , :presence =>true, :uniqueness => true
      validates :password , :presence =>true
      #validates :confirm_password , :presence =>true
      validates :name , :presence =>true , :uniqueness => true

      def get_super_key
         self.super_key
      end


      def  friends
          friendships=Friendship.all.select{|fr|  (fr.user.id==self.id)}
          friends=friendships.collect{|fr| fr.friend}
          friends
      end

      def password
          @password ||= Password.new(password_hash)
      end

      def password=(new_password)
          @password = Password.create(new_password)
          self.password_hash = @password
      end


end