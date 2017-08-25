class RecordsController < ApplicationController

  def index
    # test de code pour search
    @records = Record.search(params[:search])
  end
  end

  def show
    @record = Record.find(params[:id])
  end




end




