# Application Helper
module ApplicationHelper
  def period_to_time(period)
    # 1 => 00:15
    # 2 => 00:45
    # 48 => 23:45
    return if period.nil?
    min = ((period - 1) * 30 + 15) * 60
    Time.zone.local(0) + min
  end

  def period_to_schedule(period)
    # 1 => '0'
    # 2 => '0.5'
    # 3 => '1'
    # 48 => '23.5'
    return '' if period.nil?
    if period.odd?
      ((period - 1) / 2).to_s
    else
      ((period - 1) / 2.0).to_s
    end
  end
end
