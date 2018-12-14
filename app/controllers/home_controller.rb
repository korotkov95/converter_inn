class HomeController < ApplicationController
  def index
  end

  def parse
    allinn = params[:form][:inn]
    @results_hash = Hash.new
    @all_stat = 0
    @good_stat = 0
    @bad_stat = 0
    @other_stat = 0
    @error_stat = 0
    allinn.split("\r\n").each do |inn|
      begin
        url = "http://www.portal.nalog.gov.by/grp/getData?unp=#{inn}&charset=UTF-8"
        response = HTTParty.get(url, format: :xml)
        inn_c = Hash.from_xml(response.body)["ROWSET"]["ROW"]["VUNP"]
        stat_c = Hash.from_xml(response.body)["ROWSET"]["ROW"]["VKODS"]
        @results_hash.update(inn_c => stat_c)
        @all_stat += 1
        if stat_c == "Действующий"
          @good_stat += 1
        elsif stat_c == "Ликвидирован" or "В стадии ликвидации"
          @bad_stat += 1
        else
          @other_stat += 1
        end
      rescue NoMethodError
        @results_hash.update(inn => "Не существует")
        @all_stat += 1
        @error_stat += 1
        next
      end
    end
    render :index
  end
end

# def
# 191111259
# 101179571
# 190837422
# 190909930
# 191063786
# 192381206
# 191113330
# 190700600
# 101251041
# 806000181
# 806000258
# 806000299
# 806000311
# 806000393
# 806000429
# 806000431
# 806000508
# 806000510
# 806000536
# 806000549
# 806000551
# 806000564
# 806000577
# 806000592
# 806000602
# 806000615
# 806000628
# 806000630

# 190436848
# 100063699
# 190735914
# 790916191
# 123456789
# 290505026
# 192456501
# 192369430
# end
