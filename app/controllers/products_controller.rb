class ProductsController < ApplicationController
  def index
    @categories=Category.order(name: :asc).load_async
   # @products=Product.all.with_attached_photo.load_async

   # if params[:category_id]
   #   @products = @products.where(category_id: params[:category_id])
   # end
   # if params[:min_price].present?
   #   @products = @products.where("price >= ?", params[:min_price])
   # end

   # if params[:max_price].present?
   #   @products = @products.where("price <= ?", params[:max_price])
   # end

    
    #if params[:query_text].present?
    #  @products = Product.search_full_text(params[:query_text])
    #end

   #order_by={newest: "created_at DESC",expensive: "price DESC",cheapest: "price ASC"}.fetch(params[:order_by]&.to_sym,"Created_at DESC")
   #  puts order_by+"--------------------------------------------------------------------------------------------"
   # @products=@products.order(order_by).load_async

    @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async, items: 12)


  end
  def show
    product
  end

  def new
    @product=Product.new
  end
  def create
    @product=Product.new(product_params)
    if @product.save
      redirect_to products_path,notice: t('.created'),status: :see_other
    else
       render :new,status: :unprocessable_entity 
    end
  end
  def product_params
    params.require(:product).permit(:title,:description,:price,:photo,:category_id)
  end

  def edit
    product
  end

  def update
    if product.update(product_params)
      puts 'funciona el redireccionamiento-----------------------------------------------------------'
      redirect_to products_path, notice: t('.updated')
    else
      render :edit, status: :unproceassable_entity
    end
  end

  def destroy
    puts 'Se esta eliminando _________________---------------------------------------------_________________________________----------------a'
    product.destroy
    puts 'Se esta eliminando _________________---------------------------------------------_________________________________----------------a'
    redirect_to products_path, notice: t('.deleted')
  end

  def product_params_index
    params.permit(:category_id,:min_price,:max_price,:query_text,:order_by)
  end

  def product
    puts 'esta pasando en el controller---------------'
    puts 'este es el params id'+Product.find(params[:id]).title
    @product=Product.find(params[:id])
    puts 'este es el product '+@product.price
  end
end
