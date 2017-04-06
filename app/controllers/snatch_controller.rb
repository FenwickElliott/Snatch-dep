class SnatchController < ApplicationController
  require 'rest-client'
  require 'JSON'
  def signup
  end

  def snatch
    @rc = JSON.parse RestClient.get "https://api.spotify.com/v1/tracks/6NPVjNh8Jhru9xOmyQigds"
  end

  def about
  end

  def callback
    @response = request.env['omniauth.auth']
  end
end
