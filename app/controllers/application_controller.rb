class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  protect_from_forgery with: :exception
  include SessionsHelper
  include PeopleHelper
  include OthersHelper
end
