class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]



  def dashboard

  #1.


  end

  def go_to_wantlist
    redirect_to wantlist_discogs_path
  end


end
