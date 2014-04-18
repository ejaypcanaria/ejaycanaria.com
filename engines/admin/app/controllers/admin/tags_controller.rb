module Admin
  class TagsController < ApplicationController

    def get_all_tags

      tags = Tag.all

      respond_to do |format|
        format.json { render json: tags }
      end
    end

  end
end
