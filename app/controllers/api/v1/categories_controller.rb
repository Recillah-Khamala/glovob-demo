module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        @categories = Category.all
        render json: @categories
      end
    end
  end
end 