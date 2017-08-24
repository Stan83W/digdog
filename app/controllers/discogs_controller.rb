class DiscogsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:authenticate, :callback]
  before_action :set_client

  def authenticate
    app_key      = ENV["DISCOGS_API_KEY"]
    app_secret   = ENV["DISCOGS_API_SECRET"]
    request_data = @discogs.get_request_token(app_key, app_secret, "http://localhost:3000/discogs/callback")
    session[:request_token] = request_data[:request_token]

    redirect_to request_data[:authorize_url]
  end

  def callback
    if session[:request_token].is_a? OAuth::RequestToken
      request_token = session[:request_token]
    else
      consumer      = OAuth::Consumer.new(session[:request_token]["consumer"])
      request_token = OAuth::RequestToken.from_hash(consumer, { oauth_token: session[:request_token]["token"], oauth_token_secret: session[:request_token]["secret"]})
    end

    verifier        = params[:oauth_verifier]
    access_token    = @discogs.authenticate(request_token, verifier)

    session[:request_token] = nil
    session[:access_token]  = access_token

    redirect_to wantlist_discogs_path
  end

  def index
    @results = EbayScrapperService.find_by_keywords(params[:query])
  end

  def wantlist

    if @discogs.authenticated?

      #1 Call à l'api
      @user     = @discogs.get_identity
      @response = @discogs.get_user_wantlist(@user.username)
      @records = []
      wants = @response.wants

      #wants digdog afin de les exclure de @records
      #checker methode where
      @wants = Want.where(user_id: current_user.id)

      #2 Pour chaque item de l'api, créer un Record (Record.new), mais
      # ne pas le persister en base (pas de save/create)

      wants.each do |want|
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

      #3 -> return array de records : @records

      #4 --> retrieve records present in digdog wantlist from discogs wantlist to avoid duplicate
      @records = @records - @wants.map(&:record)

    else

      redirect_to authenticate_discogs_path

    end

  end

  def show
    @record = @discogs.get_release(params[:id])
  end

  def whoami
    @user = @discogs.get_identity
  end

  private

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
