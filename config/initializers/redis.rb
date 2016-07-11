require 'redis'

uri =
  if ENV["DISNEYWT_REDIS_PATH"]
    { path: ENV["DISNEYWT_REDIS_PATH"] }
  else
    {
      host: ENV["DISNEYWT_REDIS_HOST"],
      port: ENV["DISNEYWT_REDIS_PORT"],
      password: ENV["DISNEYWT_REDIS_PASSWORD"]
    }
  end

REDIS = Redis.new(uri)
