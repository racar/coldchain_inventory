class MantenimientosController < ApplicationController
  before_action :set_mantenimiento, only: [:show, :edit, :update, :destroy]

  respond_to :html

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

  def export_excel

    #Items.where('mantenimiento = ?','Si')
    @mantenimientos = Mantenimientos.all
    spreadsheet = StringIO.new

    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => 'SflsGestacional'
    pos_columna = 0

    sheet1.row(pos_columna).push 'Equipo','Serial','Enero','Febrero','Marzo','Abril',
                                  'Mayo','Junio','Julio','Agosto','Septiembre','Octubre',
                                    'Noviembre','Diciembre','Mantenimientos Preventivos Programados',
                                      'Mantenimientos Preventivos Realizados', 'Observaciones'

    @mantenimientos.each do |mantenimiento|
      pos_columna += 1

    end

    book.write spreadsheet
    send_data spreadsheet.string, :filename => "seguimiento_redfrio.xls", :type =>  "application/vnd.ms-excel"


  end

  private
    def set_mantenimiento
      @mantenimiento = Mantenimiento.find(params[:id])
    end

    def mantenimiento_params
      params.require(:mantenimiento).permit(:man_programados, :man_realizados, :observaciones, :fecha_firma, :fecha_vigencia, :supervisor,:cargo_supervisor,:fecha_man1,:fecha_man2,:fecha_man3,:fecha_man4,:fecha_man5,:fecha_man6,:fecha_man7,:fecha_man8,:fecha_man9,:fecha_man10,:fecha_man11,:fecha_man12)
    end
end
