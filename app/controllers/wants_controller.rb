class WantsController < ApplicationController
  def create
    @user = current_user
    @want = Want.new
    @want.record_id = params[:record_id]
    @want.user_id = @user.id
    @want.save
    if @want.save
      redirect_to wantlist_discogs_path
      #affichage / réorganisation de la page
    else
      #afficher message de "pas sauvé / merci de faire..."
    end
  end
end


