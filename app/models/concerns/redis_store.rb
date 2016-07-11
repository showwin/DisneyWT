# Redis module
module RedisStore
  extend ActiveSupport::Concern

  # class methods
  module ClassMethods
    def store_calendar(park, begin_date, end_date, result)
      key = "#{park}#{begin_date}#{end_date}AVG"
      future = Time.zone.today <= end_date
      seconds = future ? SHORT_EXPIRE_SECONDS : LONG_EXPIRE_SECONDS
      REDIS.set(key, result.to_json)
      REDIS.expire(key, seconds)
    end

    def restore_calendar(park, begin_date, end_date)
      cache = REDIS.get("#{park}#{begin_date}#{end_date}AVG")
      JSON.parse(cache).map { |k, v| [Date.parse(k), v] }.to_h if cache
    end
  end
end
