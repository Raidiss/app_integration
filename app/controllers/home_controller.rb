class HomeController < ApplicationController
  def index
    @url_params = {
      response_type: 'code',
      client_id: '306',
      redirect_uri: 'http://localhost:3000/authentication/index.html'
    }
  end
end
