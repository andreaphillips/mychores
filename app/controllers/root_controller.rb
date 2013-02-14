class RootController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  layout 'application'

  def index

  end

  def login

  end

end
