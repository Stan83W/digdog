class WantsController < ApplicationController
  def create
    @user = current_user
    @wants = Want.where(user_id: @user.id)
    @want = Want.new
    @want.record_id = params[:record_id]
    @want.user_id = @user.id
    if @wants.count < 10
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

  def destroy
    @want = Want.find(params[:id])
    @want.destroy
    if @want.destroy
      respond_to do |format|
        format.html { redirect_to wantlist_discogs_path }
        format.js  # <-- will render `app/views/wants/destroy.js.erb`
      end

      #affichage / réorganisation de la page
    else
      #afficher message de "pas sauvé / merci de faire..."
    end
  end
end
