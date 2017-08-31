class WantsController < ApplicationController
  def create
    @user = current_user
    @want = Want.new
    @record = Record.find(params[:record_id])
    @want.record = @record
    @want.user_id = @user.id
    @wants = Want.where(user_id: @user.id)
    @status = 'none'
    if @wants.count < 10
      if @want.save
      	@status = 'wanted'
      	FindRecordItemsJob.perform_now(@record)
      	findings = Finding.where(record_id: @record.id)
      	@status = 'found' if !findings.nil? && !findings.empty?
        respond_to do |format|
          format.html { redirect_to wantlist_discogs_path }
          format.js  # <-- will render `app/views/wants/create.js.erb`
        end
      end
    end
  end

  def destroy
    @wants = Want.where(user_id: current_user.id)
    @record = Record.find(params[:record_id])
    @want = @wants.find_by(record_id: @record.id)
    if @want.destroy
      respond_to do |format|
        format.html { redirect_to wantlist_discogs_path }
        format.js  # <-- will render `app/views/wants/destroy.js.erb`
      end
    end
  end
end
