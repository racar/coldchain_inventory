class MantenimientosController < ApplicationController
  before_action :set_mantenimiento, only: [:show, :edit, :update, :destroy]

  def new
    @mantenimiento = Mantenimiento.new
  end

  def edit
  end

  def create

  end

  def update
    if @mantenimiento.update(mantenimiento_params)
      redirect_to :root, notice: 'El Mantenimiento fue actualizado.'
    else
      render :edit
    end
  end

  def destroy
  end

  private
    def set_mantenimiento
      @mantenimiento = Mantenimiento.find(params[:id])
    end

    def mantenimiento_params
      params.require(:mantenimiento).permit(:man_programados, :man_realizados, :observaciones, :fecha_firma, :fecha_vigencia, :supervisor,:cargo_supervisor,:fecha_man1,:fecha_man2,:fecha_man3,:fecha_man4,:fecha_man5,:fecha_man6,:fecha_man7,:fecha_man8,:fecha_man9,:fecha_man10,:fecha_man11,:fecha_man12)
    end
end
