require 'grape'
require 'rack/stream'
require 'redis'
require 'redis/connection/synchrony'
require 'uri'

class API < Grape::API
  default_format :txt

  helpers do
    include Rack::Stream::DSL
    REDIS_CONFIG = URI.parse(ENV["REDISTOGO_URL"] || "redis://127.0.0.1:6379/0")

    def redis
      @redis ||= Redis.new({
        :host     => REDIS_CONFIG.host,
        :port     => REDIS_CONFIG.port,
        :password => REDIS_CONFIG.password
      })
    end

    def build_message(text)
      redis.rpush 'messages', text
      redis.ltrim 'messages', 0, 50
      redis.publish 'messages', text
      text
    end
  end

  resources :messages do
    get do
      after_open do
        # subscribe after_open b/c this runs until the connection is closed
        redis.subscribe 'messages' do |on|
          on.message do |channel, msg|
            chunk msg
          end
        end
      end

      status 200
      header 'Content-Type', 'application/json'
      chunk *redis.lrange('messages', 0, 50)
      ""
    end

    post do
      status 201
      build_message(params[:text])
    end
  end
end