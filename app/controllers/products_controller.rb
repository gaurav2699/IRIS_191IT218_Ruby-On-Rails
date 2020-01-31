class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # GET /products
  # GET /products.json
  def index
    @products = Product.all.order("created_at desc")
  end
  def orders

  end
  # GET /products/1
  # GET /products/1.json
  def show
  end
  def buy
    @product=Product.find(params[:id])
    fail=0
      if @product.brought_by == nil
        user=User.find_by(id: current_user.id)
        if user.balance>=@product.const
        user.update(balance: user.balance-@product.cost)
        user1=User.find_by(id: @product.user_id)
        user1.update(balance: user1.balance+ @product.cost)
        @product.update(brought_by: current_user.id, user_id: current_user.id)
      else
        fail=1
      end
    end

      respond_to do |format|
        if @product.bought_by!=nil and fail==0
          format.html { redirect_to @product, notice: 'Product was successfully bought' }
          format.json { render :show, status: :ok, location: @product }
        elsif @product.bought_by==nil  and fail ==1
          format.html {  redirect_to @product, notice: 'Low Balance' }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        else
          format.html {  redirect_to @product, notice: 'Error' }
          format.json { render json: @product.errors, status: :unprocessable_entity}
        end
      end
end
  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user = current_user
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :age, :cost, :address, :image, :brought_by)
    end
end
