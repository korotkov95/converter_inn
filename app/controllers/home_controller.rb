class HomeController < ApplicationController
  def index
  end

  def parse
    allinn = params[:form][:inn]
    @results_hash = Hash.new
    count = 1
    allinn.split("\r\n").each do |inn|
      url = "http://www.portal.nalog.gov.by/grp/getData?unp=#{inn}&charset=UTF-8"
      response = HTTParty.get(url, format: :xml)
      inn_c = Hash.from_xml(response.body)["ROWSET"]["ROW"]["VUNP"]
      stat_c = Hash.from_xml(response.body)["ROWSET"]["ROW"]["VKODS"]
      @results_hash.update(inn_c => stat_c)
    end
    render :index
  end
end
