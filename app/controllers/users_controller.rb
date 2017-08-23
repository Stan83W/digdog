class UsersController < ApplicationController


  def wants?
    @user_records = Record.user.all
    @user_wants = @user_records.wants
    puts @user_wants
  end

  def dashboard

  end
end
