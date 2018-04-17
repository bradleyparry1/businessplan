class ActualsController < ApplicationController
  def view
    @actuals = Actual.all
  end
end
