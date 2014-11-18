class WelcomeController < ApplicationController
  skip_before_action :require_login
  def index
       if current_user
          redirect_to  keys_path
       else
          redirect_to "/login"
       end
    end
end