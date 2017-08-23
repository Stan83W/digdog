class UsersController < ApplicationController

  def index

  end



  def wants

    @user = current_user
    @wants =  User.wants

    @wants.each do |want|
      Want.create

  end







    # @user = current_user
    # @user_records = Record.user.all
    # @user_wants = @user_records.wants

    #
    #créer une méthode pour récupérer les wants du user : User.wants
    #


  end

  def dashboard

  end



end
