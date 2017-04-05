class SnatchController < ApplicationController
  def signup
  end

  def snatch
    @response = request.env['omniauth.auth']
  end

  def about
  end
end
