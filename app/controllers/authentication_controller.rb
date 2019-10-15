require 'oauth2'
require 'rest-client'
require 'ostruct'
require 'json'

CLIENT_ID = 306
CLIENT_SECRET = 'bc7764d2b566703f8c8b7abd3e4d8bcc36b1fad8'


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
      RestClient.post( url, payload, {content_type: :json, accept: :json})
      @response = RestClient.post(url, payload, {content_type: :json, accept: :json})
      avaza_token = @response
      # redirect_to company_index_path
   end
end
