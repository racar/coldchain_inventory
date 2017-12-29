class InstitucionsController < ApplicationController
  before_action :set_institucion, only: [:show, :edit, :update, :destroy]

  def new
    @institucion = Institucion.new
  end

  def edit
  end

  def create
    params[:institucion][:remaining_quantity] = params[:institucion][:quantity]
    @institucion = Institucion.new(institucion_params)

    if @institucion.save
      redirect_to :root, notice: 'institucion was successfully created.'
    else
      render :new
    end
  end

  def update
    if @institucion.update(institucion_params)
      redirect_to :root, notice: 'Institucion was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @institucion.destroy
    redirect_to institucion_url, notice: 'Institucion was successfully destroyed.'
  end

  private
    def set_institucion
      @institucion = Institucion.find(params[:id])
    end

    def institucion_params
      params.require(:institucion).permit(:name, :caracter, :direccion, :nit, :cod_habilita, :temperatura)
    end
end
