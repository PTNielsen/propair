class CallbackController < ApplicationController
  def slack
    request.env["omniauth.params"]["state"]
  end
end