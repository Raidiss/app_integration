class CompanyController < ApplicationController
  def index
    @companies = avaza_token
  end
end
