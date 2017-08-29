class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def no_access
    redirect_to root_path if current_user.has_access
  end
end
