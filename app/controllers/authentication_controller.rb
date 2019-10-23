require 'oauth2'
require 'rest-client'
require 'ostruct'
require 'json'

CLIENT_ID = 306
CLIENT_SECRET = 'bc7764d2b566703f8c8b7abd3e4d8bcc36b1fad8'
TOKEN_ID = 1234567890


class AuthenticationController < ApplicationController
  def index
    code = request.query_parameters["code"]
    url = 'https://liquidconsulting.avaza.com/oauth2/token' 
    payload = {
     code: code,
     grant_type: 'authorization_code',
     client_id: CLIENT_ID,
     client_secret: CLIENT_SECRET,
     redirect_uri: "http://localhost:3000/authentication/index.html"}
     response = JSON.parse(RestClient.post(url, payload, {content_type: :json, accept: :json}))

     response["token_id"] = TOKEN_ID
     auth = Authentication.find_by(token_id: TOKEN_ID)
     if auth.nil?
      auth = Authentication.new(response)
      auth.save
     else
      data = {
        access_token: response["access_token"], 
        refresh_token: response["refresh_token"],
        token_type: response["token_type"],
        expires_in: response["expires_in"],
        restricted_to: response["restricted_to"]
      }
      auth.update(data)
     end 

    #  redirect_to company_index_path
    #  redirect_to expense_index_path
    redirect_to project_index_path
   end
end
