class FindingsController < ApplicationController

  def all
    @findings = Finding.all
  end

  def create
    @user = current_user
    @finding = Finding.new



    @finding.record_id = params[:record_id]

    #r


    user_findings = []

    user.wants.each do |want|

      want_findings = Finding.where(record_id: want.record_id)

      user_findings << want_findings

end

return user_findings







    @finding.record.user_id = @user.id
    @finding.save
    if @finding.save
      redirect_to wantlist_discogs_path
    else
    #afficher message de "pas sauvé / merci de faire...
    end
end
