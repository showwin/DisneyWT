# Hongkong Disney Land Past
class HdlPast < ActiveRecord::Base
  include RedisStore

  def waittime_with_status
    status ? waittime : -1
  end

  class << self
    def average_waittime(begin_date, end_date)
      # result:
      # {
      #   Wed, 01 Jun 2016 => 15,  # date => waittime
      #   Thu, 02 Jun 2016 => 30,
      # }
      cached = restore_calendar(HDL_STRING, begin_date, end_date)
      return cached if cached
      record = HdlPast.where(status: true).where(name: HDL_MAIN_ATTRACTIONS)
                      .where('21 <= period AND period <= 40')
                      .where('? <= date AND date <= ?', begin_date, end_date)
                      .group(:date).select('AVG(waittime) AS waittime, date')
      result = {}
      (begin_date..end_date).each { |date| result[date] = 0 }
      record.each { |r| result[r.date] = r.waittime }
      store_calendar(HDL_STRING, begin_date, end_date, result)
      result
    end

    def waittimes_on(date)
      # result: [{
      #   'at' => 08:45,      # waittime at
      #   'wb_omnibus' => 5,  # 'att_id' => waittime
      #   'wb_gallery' => 20
      # }]
      result = {}
      s = HdlSchedule.find_by(date: date)
      s.open_period.upto(s.close_period - 1) do |period|
        result[period] = { 'at' => period }
      end
      HdlPast.where(date: date).find_each do |tp|
        next unless (s.open_period...s.close_period).cover?(tp.period)
        result[tp.period][tp.name] = tp.waittime_with_status
      end
      result
    rescue
      {}
    end
  end
end
