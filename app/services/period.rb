# PeriodConverter
class Period
  class << self
    def to_time(period)
      # 1 => 00:15
      # 2 => 00:45
      # 48 => 23:45
      min = ((period - 1) * 30 + 15) * 60
      Time.zone.local(0) + min
    end
  end
end
