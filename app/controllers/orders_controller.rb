class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
    @members = Member.all
    @items = Item.where('institucion_id = ?',current_user.institucion_id)
    @active = Order.active?
    @expired = Order.expired?
  end

  def old
    @inactive = Order.where('institucion_id = ?',current_user.institucion_id)

  end

  def renew
    @current_user = current_user
    @order = Order.find_by_id(params[:id])
    Order.renew(params[:id])
    redirect_to :root
    flash[:notice] = "Renewed for 7 days from now. Enjoy!"

    begin
      OrderMailer.delay.renew_order(@order, @current_user).deliver
    rescue Exception => e
    end
  end

  def disable
    borrowed_qty = Order.find_by_id(params[:id]).quantity.to_i
    @borrowed_item = Order.find_by_id(params[:id]).item
    @borrowed_item.increment!(:remaining_quantity, borrowed_qty)
    @current_user = current_user
    @order = Order.find_by_id(params[:id])
    Order.disable(params[:id])
    redirect_to :root
    flash[:notice] = "Item marked as returned. Thank you!"

    begin
      OrderMailer.delay.return_order(@order, @current_user).deliver
    rescue Exception => e
    end
  end

  def new
    @order = Order.new

  end

  def create
    @order = Order.new(order_params)
    @order.institucion_id = current_user.institucion_id
    if @order.save
      redirect_to :root, notice: 'Solicitud ingresada.'
    else
      render :new
    end
  end

  def destroy
    borrowed_qty = @order.quantity.to_i
    @borrowed_item = @order.item
    @borrowed_item.increment!(:remaining_quantity, borrowed_qty)
    @current_user = current_user
    @order.destroy

    redirect_to orders_url, notice: 'Order was successfully destroyed.'
    begin
      OrderMailer.delay.cancel_order(@order, @current_user).deliver
    rescue Exception => e
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:quantity, :expire_at, :status, :item_id, :member_id, :category_id)
    end
end
