# History Controller
class HistoriesController < ApplicationController
  def tdl_index
    @cal_jam = TdlPast.average_waittime(cal_first_date, cal_last_date)
    @cal_schedule = TdlSchedule.from_to(cal_first_date, cal_last_date)
    @cal_jam_old = TdlPast.average_waittime(cal_1y_ago_first_date, cal_1y_ago_last_date)
    @cal_schedule_old = TdlSchedule.from_to(cal_1y_ago_first_date, cal_1y_ago_last_date)
    @waittimes = TdlPast.waittimes_on(params_date)
    @date = params_date
    @type = 'tdl'
  end

  def tds_index
    @cal_jam = TdsPast.average_waittime(cal_first_date, cal_last_date)
    @cal_schedule = TdsSchedule.from_to(cal_first_date, cal_last_date)
    @cal_jam_old = TdsPast.average_waittime(cal_1y_ago_first_date, cal_1y_ago_last_date)
    @cal_schedule_old = TdsSchedule.from_to(cal_1y_ago_first_date, cal_1y_ago_last_date)
    @waittimes = TdsPast.waittimes_on(params_date)
    @date = params_date
    @type = 'tds'
  end

  def sdl_index
    @cal_jam = SdlPast.average_waittime(cal_first_date, cal_last_date)
    @cal_schedule = SdlSchedule.from_to(cal_first_date, cal_last_date)
    @cal_jam_old = SdlPast.average_waittime(cal_1y_ago_first_date, cal_1y_ago_last_date)
    @cal_schedule_old = SdlSchedule.from_to(cal_1y_ago_first_date, cal_1y_ago_last_date)
    @waittimes = SdlPast.waittimes_on(params_date)
    @date = params_date
    @type = 'sdl'
  end

  def hdl_index
    @cal_jam = HdlPast.average_waittime(cal_first_date, cal_last_date)
    @cal_schedule = HdlSchedule.from_to(cal_first_date, cal_last_date)
    @cal_jam_old = HdlPast.average_waittime(cal_1y_ago_first_date, cal_1y_ago_last_date)
    @cal_schedule_old = HdlSchedule.from_to(cal_1y_ago_first_date, cal_1y_ago_last_date)
    @waittimes = HdlPast.waittimes_on(params_date)
    @date = params_date
    @type = 'hdl'
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
