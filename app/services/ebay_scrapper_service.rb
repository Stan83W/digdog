class EbayScrapperService
  @api_key = ENV["EBAY_API_KEY"]
  @base_api_url = "http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsAdvanced&SERVICE-VERSION=1.0.0&RESPONSE-DATA-FORMAT=JSON&GLOBAL-ID=EBAY-US&SECURITY-APPNAME=#{@api_key}"

  def self.find_by_keywords(keywords)
    unless keywords.nil?
      keywords = CGI::escape(keywords)
      url = @base_api_url + "&categoryId=11233&keywords=#{keywords}"
      json_response = JSON.parse(open(url).read)
      @results = json_response["findItemsAdvancedResponse"][0]["searchResult"][0]["item"]
    end
    return @results ||= []
  end

  def self.create_findings(records)
    records.each do |record|
      results = self.find_by_keywords(record.artists[0]["name"] + "+" + record.title)
      p results
      results.each do |item|
        if Finding.find_by(title: item["title"][0]).nil?
          finding = Finding.create(
            provider: "Ebay",
            title: item["title"][0],
            location: item["location"][0],
            thumb: item["galleryURL"][0],
            url: item["viewItemURL"][0],
            price: item["sellingStatus"][0]["currentPrice"][0]["__value__"].to_f,
            currency: item["sellingStatus"][0]["currentPrice"][0]["@currencyId"]
          )
          finding.record = record
          finding.save!
        end
      end
    end
  end

  private
end
