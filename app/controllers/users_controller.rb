class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def dashboard
    @wants = current_user.wants
    @records = current_user.wants
  end
end
