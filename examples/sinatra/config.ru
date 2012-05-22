require 'bundler/setup'
require 'sinatra/base'
require 'rack/stream'
require 'redis'
require 'redis/connection/synchrony'
require 'json'

class App < Sinatra::Base
  include Rack::Stream::DSL

  get '/' do
    erb :index
  end

  get '/messages' do
    after_open do
      # subscribe after_open b/c synchrony will wait for
      # this forever
      redis.subscribe 'messages' do |on|
        on.message do |channel, msg|
          chunk msg
        end
      end
    end

    status 200
    headers('Content-Type' => 'application/json')
    redis.lrange 'messages', 0, 50
  end

  post '/messages' do
    message = build_message(params[:text])
    redis.rpush 'messages', message
    redis.ltrim 'messages', 0, 50
    redis.publish 'messages', message

    status 201
    params[:text]
  end

  protected

  def redis
    @redis ||= Redis.new
  end

  def build_message(text)
    {:text => text, :stream_transport => stream_transport}.to_json
  end
end

use Rack::Stream
run App