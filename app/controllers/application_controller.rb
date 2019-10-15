class ApplicationController < ActionController::Base

    def avaza_token=(new_token)
        @token = new_token
    end
    def avaza_token
      @token
    end

end
