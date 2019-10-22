require 'date'
require 'rest-client'
require 'ostruct'
require 'json'
require 'uri'

TOKEN_ID = 1234567890

class ExpenseController < ApplicationController
  def index
  end

  def show
    start_date = URI.encode(5.days.ago.beginning_of_day.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ"))
    end_date = URI.encode(1.days.ago.end_of_day.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ"))
    authentication = Authentication.find_by(token_id: TOKEN_ID)
    url = "https://api.avaza.com/api/Expense?ProjectID=#{params[:id]}&ExpenseDateFrom=#{start_date}&ExpenseDateTo=#{end_date}"
    headers = {Authorization: "Bearer #{authentication.access_token}"}
    data = JSON.parse(RestClient.get(url, headers), object_class: OpenStruct)
    @expenses = data.Expenses
  end
end
 