class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token #refactor in an api
  def index
    @items = Item.where('institucion_id = ?',current_user.institucion_id)
  end

  def new
    @categorias = Category.all
    @item = Item.new
  end

  def edit
  end

  def create
    params[:item][:remaining_quantity] = params[:item][:quantity]
    @item = Item.new(item_params)
    @item.institucion_id = current_user.institucion_id
    if @item.save
    #  if @item.mantenimiento === 'Si'
        @mantenimiento = Mantenimiento.new
        @mantenimiento.item_id = @item.id
        @mantenimiento.save
    #  end
      redirect_to :root, notice: 'Nuevo Item del inventario Creado.'
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to :root, notice: 'Item del inventario actualizado.'
    else
      render :edit
    end
  end

  def destroy
    @item.mantenimiento.destroy
    @item.destroy
    redirect_to items_url, notice: 'El Item fué eliminado del inventario.'
  end

  def getMarcas
    #[["Refrigerador/Congelador","Refrigerador/Congelador"], ["Termo","Termo"], ["Caja","Caja"], ["Aire acondicionado","Aire"], ["Termometro","Termometro"]]
    puts params[:categoria]
    @marcas = Marca.where(['category_id = ?',params[:categoria]])

    respond_to do |format|
       format.json { render :json => @marcas }
     end

  end

  def getModelos
    @modelos = Modelo.where('category_id = ? and marca_id = ?', params[:categoria], params[:marca])
    respond_to do |format|
      format.json { render :json => @modelos }
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :category, :marca, :modelo, :serial, :mantenimiento, :num_manten_year, :modelo_id, :marca_id, :category_id, :regulador, :potencia, :transfer_automatica, :cargador_bateria, :capacidad_refrigeracion, :volumen, :quantity, :num_paquetes, :dimensiones, :funciona, :compresor, :num_compresores, :monitoreo, :tiene_mantenimiento)
  end
end
