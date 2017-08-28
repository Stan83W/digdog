class RecordsController < ApplicationController
  def show
    @record = Record.find(params[:id])
    @wants = Want.where(user_id: current_user.id)
    @wants = @wants.map(&:record)
  end
end
