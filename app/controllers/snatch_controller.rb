class SnatchController < ApplicationController
  def signup
  end

  def snatch
    render text: request.env['omniauth.auth'].to_yaml
  end

  def about
  end

  def create
    render text: request.env['omniauth.auth'].to_yaml
  end
end
