TOKEN_ID = 1234567890

class CompanyController < ApplicationController
  def index
    authentication = Authentication.find_by(token_id: TOKEN_ID)
    url = 'https://api.avaza.com/api/Company'
    headers = {Authorization: "Bearer #{authentication.access_token}"}
    @data = JSON.parse(RestClient.get(url, headers), object_class: OpenStruct)
  end
end