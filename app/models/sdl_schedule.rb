# Shanghai Disney Land Schedule
class SdlSchedule < ActiveRecord::Base
  class << self
    def from_to(begin_date, end_date)
      # result:
      # {
      #   '2016-01-01' => { open_peiod: 19, close_period: 45 } # date => schedule
      # }
      result = {}
      (begin_date..end_date).each { |date| result[date] = {} }
      s = SdlSchedule.where('? <= date AND date <= ?', begin_date, end_date)
      s.each do |r|
        result[r.date] = { open_period: r.open_period, close_period: r.close_period }
      end
      result
    end
  end
end
