class ProductsController < ApplicationController
  before_action :search_product, only: [:index, :search]
  def index
    @products = Product.all
    set_product_column
    set_category_column
  end

  # 「.result」で@pに格納された検索結果を取得する、「.includes(:category)」でN+1問題の解消
  def search
    @results = @p.result.includes(:category)
  end

  private
  def search_product
    @p = Product.ransack(params[:q]) # 検索オブジェクトを生成
  end

  def set_product_column
    @product_name = Product.select("name").distinct # 指定したカラム（name）の重複する値を取り除く
    @product_size = Product.select("size").distinct
    @product_status = Product.select("status").distinct
  end
  def set_category_column
    @category_name = Category.select("name").distinct
  end
end
