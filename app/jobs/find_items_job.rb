class FindItemsJob < ApplicationJob
  queue_as :default

  def perform(user)
    # @user = User.find(user_id)
    puts "Get wants"
    wants = Want.where(user_id: user.id)
    records = wants.map(&:record)
    
    # Search on Ebay
    EbayScrapperService.create_findings(records)
  end
end
