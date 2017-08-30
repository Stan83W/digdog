class FindRecordItemsJob < ApplicationJob
  queue_as :default

  def perform(record)
    
    # Search on Ebay
    EbayScrapperService.create_findings([record])
  end
end
