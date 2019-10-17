
TOKEN_ID = 1234567890

class ExpenseController < ApplicationController
  def index
   
  end

  def show
    @project_id = params[:id]
    authentication = Authentication.find_by(token_id: TOKEN_ID)
    url = 'https://api.avaza.com/api/Expense'
    headers = {Authorization: "Bearer #{authentication.access_token}"}
    @data = JSON.parse(RestClient.get(url, headers), object_class: OpenStruct)
  end
end
