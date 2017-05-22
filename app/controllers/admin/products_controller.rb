class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end



  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity)
  end
end
