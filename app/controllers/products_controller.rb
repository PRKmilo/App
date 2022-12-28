class ProductsController < ApplicationController
  def index
    @products=Product.all
  end
  def show
    @product=Product.find(params[:id])
  end

  def new
    @product=Product.new
  end
  def create
    @product=Product.new(product_params)
    if @product.save
      redirect_to products_path,notice: 'se subio bien el producto',status: :see_other
    else
       render :new,status: :unprocessable_entity 
    end
  end
  def product_params
    params.require(:product).permit(:title,:description,:price)
  end

  def edit
    @product=Product.find(params[:id])
  end

  def update
    @product=Product.find(params[:id])
    if @product.update(product_params)
      puts 'funciona el redireccionamiento'
      redirect_to products_path, notice: 'El producto se actuaizo'
    else
      render :edit, status: :unproceassable_entity
    end
  end

  def delete
  @product=Product.find(params[:id])
  @product.destroy
  redirect_to products_path, notice: 'Tu producto se elimino correctamente'
  end
end
