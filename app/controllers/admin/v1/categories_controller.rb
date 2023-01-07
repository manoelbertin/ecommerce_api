module Admin::V1
  class CategoriesController < ApiController
    before_action :load_category, only: [:show]

    def index
      @categories = load_categories
    end

    def show; end

    def create
      @category = Category.new
      @category.attributes = category_params

      @category.save!
      render :show
      rescue
        render json: { errors: { fields: @category.errors.messages } }, status: :unprocessable_entity
    end

    def update
      @category = Category.find(params[:id])
      @category.attributes = category_params
      
      @category.save!
      render :show
      rescue
        render json: { errors: { fields: @category.errors.messages } }, status: :unprocessable_entity
    end

    def destroy
      @category = Category.find(params[:id])
      @category.destroy!
    rescue
      render_error(fields: @category.errors.messages)
    end

    private

    def load_category
      @category = Category.find(params[:id])
    end

    def load_categories
      permitted = params.permit({ search: :name}, {order: {}}, :page, :length)
      Admin::ModelLoadingService.new(Category.all, permitted).call
    end

    def category_params
      return {} unless params.has_key?(:category)
      params.require(:category).permit(:id, :name)
    end
  end
end
