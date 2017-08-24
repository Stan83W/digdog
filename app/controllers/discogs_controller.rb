class DiscogsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:authenticate, :callback]
  before_action :set_client

  def wantlist

    if @discogs.authenticated?
      if current_user.discogs_wantlist.nil?
        get_wantlist
      end

      #wants digdog afin de les exclure de @records
      @wants = Want.where(user_id: current_user.id)
      @wants = @wants.map(&:record)

      @findings = Finding.all
      @findings = @findings.map(&:record)

      #2 Pour chaque item de l'api, créer un Record (Record.new)
      @records = []

      unless current_user.discogs_wantlist.nil?
        current_user.discogs_wantlist.each do |want|
          want = want["basic_information"]
          discogs_id = want["id"]

          if Record.has?(discogs_id)
            record = Record.find_by_discogs_id(discogs_id)
          else
            record = Record.create(
              discogs_id: discogs_id,
              title: want["title"],
              labels: want["labels"],
              artists: want["artists"],
              styles: want["styles"],
              year: want["year"],
              thumb: want["thumb"],
              images: get_release_images(want["id"]),
              discogs_uri: want["resource_url"]
            )
          end
          @records << record
        end
      end

      #4 --> retrieve records present in digdog wantlist from discogs wantlist to avoid duplicate
      # @records = @records - @wants.map(&:record)
    else
      redirect_to root_path
    end

  end

  def show
    @record = @discogs.get_release(params[:id])
  end

  def reload_wantlist
    get_wantlist
  end

  def whoami
    @user = @discogs.get_identity
  end

  private

  def get_wantlist
    # Fetch wantlist
    discogs_wantlist = @discogs.get_user_wantlist(current_user.username).wants
    # Save it in DB
    current_user.update(discogs_wantlist: discogs_wantlist)
  end

  def get_release_images(id)
    @discogs.get_release(id)["images"]
  end

  def set_client
    @discogs = Discogs::Wrapper.new("OAuth", session[:access_token])
  end

  # def add_want(id)
  #   release_id = "2489281"

  #   @user     = @discogs.get_identity
  #   @response = @discogs.add_release_to_user_wantlist(@user.username, release_id)
  # end

  # def edit_want
  #   release_id = "2489281"
  #   notes      = "Added via the Discogs Ruby Gem. But, you *DO* want it now!!"
  #   rating     = 5

  #   @user     = @discogs.get_identity
  #   @response = @discogs.edit_release_in_user_wantlist(@user.username,
  #                                                      release_id,
  #                                                      {:notes => notes, :rating => rating})
  # end

  # def remove_want
  #   release_id = "2489281"

  #   @user     = @discogs.get_identity
  #   @response = @discogs.delete_release_from_user_wantlist(@user.username, release_id)
  # end
end