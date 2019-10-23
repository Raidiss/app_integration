require 'date'
require 'rest-client'
require 'ostruct'
require 'json'
require 'uri'

TOKEN_ID = 1234567890


class UserController < ApplicationController
  def index
    @users = get_users
  end

  def show
    @user_id = params[:id].to_i
    @users = get_users
    @email = nil
    @users.each do |user|
      if user.UserID == @user_id
        @email = URI.encode(user.Email)
      end 
    end
    if not @email.blank?
      start_date = URI.encode(5.days.ago.beginning_of_day.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ"))
      end_date = URI.encode(1.days.ago.end_of_day.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ"))
      authentication = Authentication.find_by(token_id: TOKEN_ID)
      url = "https://api.avaza.com/api/Expense?UserEmail=#{@email}&ExpenseDateFrom=#{start_date}&ExpenseDateTo=#{end_date}"
      headers = {Authorization: "Bearer #{authentication.access_token}"}
      data = JSON.parse(RestClient.get(url, headers), object_class: OpenStruct)
      @expenses = data.Expenses
    end
  end

  private
    def get_users
      authentication = Authentication.find_by(token_id: TOKEN_ID)
      url = 'https://api.avaza.com/api/UserProfile'
      headers = {Authorization: "Bearer #{authentication.access_token}"}
      data = JSON.parse(RestClient.get(url, headers), object_class: OpenStruct)
      data.Users
    end

    def export_expenses
      
      @expenses.each do |expense|
        Date createdAt = expense.DateCreated.to_date
        dateStr = createdAt.strftime("%Y-%m-%d")
        @list = [merchant => expense.Merchant, created => dateStr , amount => (expense.Amount * 100).to_i, currency =>expense.CurrencyCode, externalID => expense.ExpenseID, category => expense.ExpenseCategoryName]
      end  

      url = 'https://integrations.expensify.com/Integration-Server/ExpensifyIntegrations'
      payload = {
            requestJobDescription=>{
                "type":"create",
                "credentials":{
                    "partnerUserID": "aa_avaza_liquidconsulting_com",
                    "partnerUserSecret": "4d618b69d544a7773ed0b4beeb1f1a0eea989138"
                }
              },
                inputSettings=> {
                    "type":"expenses",
                    "employeeEmail":"@email",
                },
            transactionList => @list
      } 

    @respose = RestClient.post(url, payload)
  end   

end