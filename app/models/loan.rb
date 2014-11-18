
class Loan < ActiveRecord::Base
 belongs_to :user
 belongs_to :key
 belongs_to :friend, class_name:  "User"
end