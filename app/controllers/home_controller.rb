class HomeController < ApplicationController
  def index
  end

  def parse
    allinn = params[:form][:inn]
    @results = []
    allinn.split("\r\n").each do |inn|
      url = "http://www.portal.nalog.gov.by/grp/getData?unp=#{inn}&charset=UTF-8"
      puts url
      response = HTTParty.get(url, format: :xml)
      @results << Hash.from_xml(response.body)["ROWSET"]["ROW"]["VUNP"] + " - " + Hash.from_xml(response.body)["ROWSET"]["ROW"]["VKODS"]
    end
    render :index
  end
end
