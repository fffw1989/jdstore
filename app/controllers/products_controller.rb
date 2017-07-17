class ProductsController < ApplicationController
 before_action :validate_search_key, only: [:search]

  def index
      if params[:category].blank?
        @products = Product.all
      else
        @category_id = Category.find_by(name: params[:category]).id
        @products = Product.where(:category_id => @category_id)
      end
  end

  def show
    @product = Product.find(params[:id])
    @photos = @product.photos.all
  end

  def update
    @product = Product.find(params[:id])

    if params[:photos] != nil
      @product.photos.destroy_all   #先清除原有的图片

      params[:photos]['avatar'].each do |a|
        @photo = @product.photos.create(:avatar => a)
      end
    end

    if @product.update(product_params)
      redirect_to admin_products_path,notice: "更新成功！"
    else
      render :edit
    end
  end


  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
       current_cart.add_product_to_cart(@product)
       flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
      flash[:warning] = "你的购物车已有此物品"
    end
    redirect_to :back
  end

  def search
    if @query_string.present?
       search_result = Product.ransack(@search_criteria).result(:distinct => true)
       @products = search_result.paginate(:page => params[:page], :per_page => 5 )
    end
  end

  protected

    def validate_search_key
      @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
      @search_criteria = search_criteria(@query_string)
    end

    def search_criteria(query_string)
      { title_or_description_cont: query_string }
    end
end
