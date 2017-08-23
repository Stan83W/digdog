class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def dashboard
  end


end
