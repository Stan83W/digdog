class RecordsController < ApplicationController
  def index
    @user_records = Record.user.all
  end

  def show
  	@record = Record.find(params[:id])
  end
end