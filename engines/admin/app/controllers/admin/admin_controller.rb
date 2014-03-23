require_dependency "admin/application_controller"

module Admin
  class AdminController < ApplicationController
    before_filter :authenticate_user!

    def index
    end

    private
  end
end
