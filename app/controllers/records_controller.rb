class RecordsController < ApplicationController


  def index
    @user_records = Record.user.all

  end


  def in_wants?
  end

  def in_findings?
  end



end

