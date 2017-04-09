class SnatchController < ApplicationController
  require 'rest-client'
  require 'JSON'
  require 'net/http'
  require 'uri'

  def signup
  end

  def snatch
  end

  def about
  end

  def callback
    @response = request.env['omniauth.auth']
    @token = @response['credentials']['token']

    @header = {
      Accept: "application/json",
      Authorization: "Authorization: Bearer #{@response['credentials']['token']}"
    }

    @song = RestClient.get("https://api.spotify.com/v1/me/player/currently-playing", @header)

    @p_name = 'Dummyy'

    snatch
  end

      def get_me
      uri = URI.parse("https://api.spotify.com/v1/me")
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer #{@token}"

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      user = JSON.parse response.body
      @user_id = user['id']
    end

    def get_song
      # uri = URI.parse("https://api.spotify.com/v1/me/player/currently-playing")
      # request = Net::HTTP::Get.new(uri)
      # request["Accept"] = "application/json"
      # request["Authorization"] = "Bearer #{@token}"

      # req_options = {
      #   use_ssl: uri.scheme == "https",
      # }

      # response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      #   http.request(request)
      # end
      # song = JSON.parse response.body
      song = JSON.parse RestClient.get("https://api.spotify.com/v1/me/player/currently-playing", @header)
      @s_uri = song['item']['uri']
    end

    def check_for_playlist
      # uri = URI.parse("https://api.spotify.com/v1/me/playlists?limit=50")
      # request = Net::HTTP::Get.new(uri)
      # request["Accept"] = "application/json"
      # request["Authorization"] = "Bearer #{@token}"

      # req_options = {
      #   use_ssl: uri.scheme == "https",
      # }

      # response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      #   http.request(request)
      # end
      # list = JSON.parse response.body

      list = JSON.parse RestClient.get("https://api.spotify.com/v1/me/playlists?limit=50", @header)

      list['items'].each do |x|
          if x['name'] === @p_name
            puts x['name'] << ' Playlist found'
            @p_id = x['id']
            return
          end
        end
        create_playlist
    end

    def create_playlist

      uri = URI.parse("https://api.spotify.com/v1/users/#{@user_id}/playlists")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer #{@token}"
      request.body = JSON.dump({
        "description" => "Your Snatched Playlist",
        "public" => false,
        "name" => "#{@p_name}"
      })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      playlist = JSON.parse response.body
      @p_id = playlist['id']
      puts "#{@p_name} playlist created. ID: #{@p_id}"
    end

    def actually_snatch
      uri = URI.parse("https://api.spotify.com/v1/users/#{@user_id}/playlists/#{@p_id}/tracks?uris=#{@s_uri}")
      request = Net::HTTP::Post.new(uri)
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer #{@token}"

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      puts response.code
    end
    
    def snatch
      get_me
      get_song
      check_for_playlist
      actually_snatch
    end
end

