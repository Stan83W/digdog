class EbayScrapperService
  @api_key = ENV["EBAY_API_KEY"]
  @base_api_url = "http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsByKeywords&SERVICE-VERSION=1.0.0&RESPONSE-DATA-FORMAT=JSON&GLOBAL-ID=EBAY-US&SECURITY-APPNAME=#{@api_key}"

  def self.find_by_keywords(keywords)
    unless keywords.nil?
      keywords = CGI::escape(keywords)
      url = @base_api_url + "&keywords=#{keywords}"
      json_response = JSON.parse(open(url).read)

      @results = json_response["findItemsByKeywordsResponse"][0]["searchResult"][0]["item"]
    end
    return @results ||= []
  end

  private
end
