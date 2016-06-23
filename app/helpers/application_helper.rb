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

  def display_waittime(waittime)
    if waittime.nil? || waittime < WAITTIME_BUSY0
      "<td class='waittime-busy0'>-</td>"
    elsif waittime < WAITTIME_BUSY1
      "<td class='waittime-busy1'>#{waittime}</td>"
    elsif waittime < WAITTIME_BUSY2
      "<td class='waittime-busy2'>#{waittime}</td>"
    elsif waittime < WAITTIME_BUSY3
      "<td class='waittime-busy3'>#{waittime}</td>"
    elsif waittime < WAITTIME_BUSY4
      "<td class='waittime-busy4'>#{waittime}</td>"
    elsif waittime < WAITTIME_BUSY5
      "<td class='waittime-busy5'>#{waittime}</td>"
    elsif waittime < WAITTIME_BUSY6
      "<td class='waittime-busy6'>#{waittime}</td>"
    elsif waittime < WAITTIME_BUSY7
      "<td class='waittime-busy7'>#{waittime}</td>"
    else
      "<td class='waittime-busy8'>#{waittime}</td>"
    end
  end
end
