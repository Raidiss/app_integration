
TOKEN_ID = 1234567890

class ProjectController < ApplicationController
  def index
    authentication = Authentication.find_by(token_id: TOKEN_ID)
    url = 'https://api.avaza.com/api/Project'
    headers = {Authorization: "Bearer #{authentication.access_token}"}
    @data = JSON.parse(RestClient.get(url, headers), object_class: OpenStruct)
  end
end
