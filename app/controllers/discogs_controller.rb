class DiscogsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:authenticate, :callback]
  before_action :set_client

  def wantlist
    if @discogs.authenticated?

      redirect_to '/no_access' if !current_user.has_access

      if current_user.discogs_wantlist.nil?
        get_wantlist
      end
      #wants digdog afin de les exclure de @records
      @wants = Want.where(user_id: current_user.id)
      @wants = @wants.map(&:record)
      #2 Pour chaque item de l'api, créer un Record (Record.new)


      @records = []
      unless current_user.discogs_wantlist.nil?
        current_user.discogs_wantlist.each do |want|
          want = want["basic_information"]
          discogs_id = want["id"]
          if Record.has?(discogs_id)
            record = Record.find_by_discogs_id(discogs_id)
            if record.styles.nil? || record.genres.nil? || record.images.nil? || record.formats.nil? || record.tracklist.nil?
              record_json = get_release_json(want["id"])
              record_json["styles"] = [] if record_json["styles"].nil?
              record_json["genres"] = [] if record_json["genres"].nil?
              record_json["images"] = [] if record_json["images"].nil?
              record_json["formats"] = [] if record_json["formats"].nil?
              record_json["tracklist"] = [] if record_json["tracklist"].nil?
              record.update(
                tracklist: record_json["tracklist"],
                styles: record_json["styles"],
                genres: record_json["genres"],
                images: record_json["images"],
                formats: record_json["formats"]
              )
            end
          else
            record_json = get_release_json(want["id"])
            record = Record.create(
              discogs_id: discogs_id,
              title: want["title"],
              labels: want["labels"],
              artists: want["artists"],
              tracklist: record_json["tracklist"],
              styles: record_json["styles"],
              genres: record_json["genres"],
              year: want["year"],
              thumb: want["thumb"],
              images: record_json["images"],
              discogs_uri: want["resource_url"],
              formats: record_json["formats"]
            )
          end
          if params[:query]
            @records = search(params[:query])
          else
            @records << record
          end
        end

        @wantlist_without_wants = @records - @wants
      end
    else
      redirect_to root_path
    end
  end

  def show
    wantlist
    @record = Record.find(params[:id])
    @findings = Finding.where(record_id: @record.id)
    load_videos(@record)
  end

  def load_videos(record)
    unless record.tracklist.nil?
      if record.videos.nil?
        
        Yt.configure do |config|
          config.api_key = ENV["YT_API_KEY"]
        end
        videos = Yt::Collections::Videos.new
        # artist_videos = videos.where(q: record.artists[0]["name"], safe_search: 'none')
        ep_videos = Hash.new

        record.tracklist.each do |track|
          track_video = videos.where(q: record.title + ' ' + record.artists[0]["name"] + '+' + track["title"], order: 'viewCount').first
          ep_videos[track["title"]] = track_video.id unless track_video.nil?
        end

        unless ep_videos.nil?
          record.update(videos: ep_videos)
        end
      end
    end
  end

  def reload_wantlist
    get_wantlist
  end

  def whoami
    @user = @discogs.get_identity
  end

  private

  def search(params)
    records = Record.arel_table
    query_string = "%#{params}%"
    param_matches_string =  ->(param){
      records[param].matches(query_string)
    }
    @records = Record.where(param_matches_string.(:title))
    #.or(param_matches_string.(:artists)))
  end

  def get_wantlist
    # Fetch wantlist
    discogs_wantlist = @discogs.get_user_wantlist(current_user.username).wants
    # Save it in DB
    current_user.update(discogs_wantlist: discogs_wantlist)
  end

  def get_release_json(id)
    @discogs.get_release(id)
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
