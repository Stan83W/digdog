class WantsController < ApplicationController
  def create
    @user = current_user
    @want = Want.new
    @want.record_id = params[:record_id]
    @want.user_id = @user.id
    @want.save
    if @want.save
      respond_to do |format|
        format.html { redirect_to wantlist_discogs_path }
        format.js  # <-- will render `app/views/wants/create.js.erb`
      end
      
      #affichage / réorganisation de la page
    else
      #afficher message de "pas sauvé / merci de faire..."
    end
  end
end


