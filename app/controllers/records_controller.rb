class RecordsController < ApplicationController
  # def index
  #   @records = Record.all
  #   #this is your "list all" that we trigger if request comes to `/fecords`
  #   if params[:title]
  #   # what if we got a query string in the request path? Overwrite our @frecords!
  #     @records = Records.where(params[:title], "Serge Gainsbourg")
  #     # the hardest part here is coming up with a good DB query.
  #   end
  # end

  def show
    @record = Record.find(params[:id])
  end
end

# :Parameters {
#   "titre"=>"Serge",
#   "controller"=>"records",
#   "action"=>"index"
# })
