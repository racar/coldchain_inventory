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
    @responsable
    category = Category.where('nombre = ?','Cuarto Frio').first
    @responsable = query_responsable(category)
    if !@responsable
      category = Category.where('nombre = ?','Refrigerador').first
      @responsable = query_responsable(category)
    end

    #Items.where('mantenimiento = ?','Si')
    #@mantenimientos = Mantenimiento.all
    @consulta = Item.joins(:mantenimiento).joins(:category).joins(:marca).joins(:modelo)
    spreadsheet = StringIO.new

    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => 'Reporte mantenimiento'
    pos_columna = 0
    sheet1.row(pos_columna).push 'NOMBRE DEL DEPARTAMENTO O DISTRITO: ' + Institucion.find(current_user.institucion_id).name

    pos_columna += 1
    sheet1.row(pos_columna).push 'EQUIPO','SERIAL','ENERO','FEBRERO','MARZO','ABRIL',
                                  'MAYO','JUNIO','JULIO','AGOSTO','SEPTIEMBRE','OCTUBRE',
                                    'NOVEMBRE','DICIEMBRE','MANTENIMIENTO PREVENTIVOS PROGRAMDOS',
                                      'MANTENIMIENTO PREVENTIVOS REALIZADOS', 'OBSERVACIONES'

    @consulta.each do |fila|
      pos_columna += 1
      sheet1.row(pos_columna).push  fila.category.nombre + " " + fila.marca.nombre + " " +fila.modelo.nombre,fila.serial,
      "","","","","","","","","","","","",fila.mantenimiento.man_programados,fila.mantenimiento.man_realizados,fila.mantenimiento.observaciones

    end

    pos_columna += 1
    sheet1.row(pos_columna).push ''
    pos_columna += 1
    sheet1.row(pos_columna).push 'DATOS DEL CONTRATO'
    pos_columna += 1
    if (@responsable)
      sheet1.row(pos_columna).push 'FECHA DE FIRMA DEL CONTRATO:',@responsable.mantenimiento.fecha_firma.to_s
      pos_columna += 1
      sheet1.row(pos_columna).push 'VIGENCIA DEL CONTRATO:',@responsable.mantenimiento.fecha_vigencia.to_s
      pos_columna += 1
      sheet1.row(pos_columna).push 'NOMBRE DEL SUPERVISOR DEL CONTRATO:',@responsable.mantenimiento.supervisor.to_s
      pos_columna += 1
      sheet1.row(pos_columna).push 'CARGO DEL SUPERVISOR DEL CONTRATO:',@responsable.mantenimiento.cargo_supervisor.to_s

    else
      sheet1.row(pos_columna).push 'INGRESE INFORMACION DE MANTENIMIENTO EN CUARTOS FRIOS O NEVERAS PARA GENERAR'
    end

    book.write spreadsheet
    send_data spreadsheet.string, :filename => "seguimiento_redfrio.xls", :type =>  "application/vnd.ms-excel"


  end

  private
    def query_responsable(category)
      @responsable = Item.joins(:mantenimiento).where('institucion_id = ? and category_id = ?',current_user.institucion_id, category.id).first
    end

    def verify_month(mes,fila)

      1.upto(12) do |i|
        "fila.fecha_man" + i
      end

    end

    def set_mantenimiento
      @mantenimiento = Mantenimiento.find(params[:id])
    end

    def mantenimiento_params
      params.require(:mantenimiento).permit(:man_programados, :man_realizados, :observaciones, :fecha_firma, :fecha_vigencia, :supervisor,:cargo_supervisor,:fecha_man1,:fecha_man2,:fecha_man3,:fecha_man4,:fecha_man5,:fecha_man6,:fecha_man7,:fecha_man8,:fecha_man9,:fecha_man10,:fecha_man11,:fecha_man12)
    end
end
