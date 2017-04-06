class SnatchController < ApplicationController
  def signup
  end

  def snatch

  end

  def about
  end

  def callback
    @response = request.env['omniauth.auth']
  end
end
