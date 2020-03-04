class Merchant::DiscountsController < Merchant::BaseController

  def new
    @discount = Discount.new
  end

  def create
    merchant = Merchant.find(current_user.merchants.first.id)
    discount = merchant.discounts.create(discount_params)
    if discount.save
      flash[:notice] = 'Discount Created'
      redirect_to '/merchant'
    else
      flash[:notice] = discount.errors.full_messages.to_sentence
      redirect_to "/merchant/discounts/new"
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    if @discount.update(discount_params)
      flash[:notice] = "Discount Updated"
      redirect_to "/merchant"
    else
      flash[:notice] = @discount.errors.full_messages.to_sentence
      redirect_to "/merchant/discounts/#{@discount.id}/edit"
    end
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to "/merchant"
  end

  private

  def discount_params
    params.require(:discount).permit(:percentage, :per_item)  
  end


end