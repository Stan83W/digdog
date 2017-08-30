class WantsController < ApplicationController
  def create
    @user = current_user
    @wants = Want.where(user_id: @user.id)
    @want = Want.new
    @want.record_id = params[:record_id]
    @want.user_id = @user.id
    if @wants.count < 10
      if @want.save
        respond_to do |format|
          format.html { redirect_to wantlist_discogs_path }
          format.js  # <-- will render `app/views/wants/create.js.erb`
        end
      end
    end
  end

  def destroy
    @wants = Want.where(user_id: current_user.id)
    @want = @wants.find_by(record_id: params[:record_id])
    if @want.destroy
      respond_to do |format|
        format.html { redirect_to wantlist_discogs_path }
        format.js  # <-- will render `app/views/wants/destroy.js.erb`
      end
    end
  end
end
