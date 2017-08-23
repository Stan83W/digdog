class WantsController < ApplicationController

  def all
    @wants = Want.all
  end

  def create
    @user = current_user
    @want = Want.new
    @want.record_id = params[:record_id]
    @want.user_id = @user.id
    @want.save
    if @want.save
      redirect_to wantlist_discogs_path
    end
  end
end
