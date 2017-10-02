class HomeController < ApplicationController
  before_action :authenticate, :except => [:index]

  def index
    @title = "Jobline Outbound Messages"
  end
end
