class UsersController < ApplicationController
  def dashboard
    @wants = current_user.wants
    @records = current_user.wants
  end
end
