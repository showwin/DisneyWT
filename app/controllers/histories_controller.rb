# History Controller
class HistoriesController < ApplicationController
  def tdl_index
    @calendar = TdlPast.average_waittime(cal_first_date, cal_last_date)
    @calendar_old = TdlPast.average_waittime(cal_1y_ago_first_date, cal_1y_ago_last_date)
    @waittimes = TdlPast.waittimes_on(params_date)
    @date = params_date
  end

  def tds_index
    @calendar = TdsPast.average_waittime(cal_first_date, cal_last_date)
    @calendar_old = TdsPast.average_waittime(cal_1y_ago_first_date, cal_1y_ago_last_date)
    @waittimes = TdsPast.waittimes_on(params_date)
    @date = params_date
  end

  def sdl_index
  end

  def hdl_index
  end

  private

  def cal_first_date
    month_first_day = params_date.beginning_of_month
    if month_first_day.wday == 0
      month_first_day.beginning_of_week + 6.days
    else
      month_first_day.beginning_of_week - 1.day
    end
  end

  def cal_last_date
    month_last_day = params_date.end_of_month
    if month_last_day.wday == 0
      month_last_day.end_of_week + 6.days
    else
      month_last_day.end_of_week - 1.day
    end
  end

  def cal_1y_ago_first_date
    month_first_day = (params_date - 1.year).beginning_of_month
    if month_first_day.wday == 0
      month_first_day.beginning_of_week + 6.days
    else
      month_first_day.beginning_of_week - 1.day
    end
  end

  def cal_1y_ago_last_date
    month_last_day = (params_date - 1.year).end_of_month
    if month_last_day.wday == 0
      month_last_day.end_of_week + 6.days
    else
      month_last_day.end_of_week - 1.day
    end
  end

  def params_date
    year = params[:year] || Time.zone.today.year
    month = params[:month] || Time.zone.today.month
    day = params[:day] || Time.zone.today.day
    Date.new(year.to_i, month.to_i, day.to_i)
  end

  def params_month
    # 5 => '05'
    format('%02d', params[:month] || Time.zone.today.month)
  end
end
