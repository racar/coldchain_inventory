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
    format = Spreadsheet::Format.new :color=> :white, :pattern_fg_color => :gray, :pattern => 1
    bold = Spreadsheet::Format.new :weight => :bold, :text_wrap => true
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => 'Reporte mantenimiento'

    pos_row = 0
    sheet1.merge_cells(pos_row,0,pos_row,4)
    sheet1.merge_cells(pos_row,5,pos_row,7)
    sheet1.merge_cells(pos_row,8,pos_row,14)
    sheet1.row(pos_row).push '','','','','','PROCESO','','','GESTIÓN DE PROMOCIÓN,  PREVENCIÓN E INTERVENCIONES INDIVIDUALES Y COLECTIVAS EN SALUD PÚBLICA','','','','','','','Código','GIPF08'
    sheet1.row(pos_row).default_format = bold
    pos_row += 1
    sheet1.merge_cells(pos_row,0,pos_row,4)
    sheet1.merge_cells(pos_row,5,pos_row,7)
    sheet1.merge_cells(pos_row,8,pos_row,14)
    sheet1.row(pos_row).push '','','','','','Formato','','','Seguimiento mantenimiento red de frío a nivel nacional','','','','','','','Versión','1'
    sheet1.row(pos_row).default_format = bold
    pos_row += 1
    sheet1.merge_cells(pos_row,0,pos_row,16)
    #sheet1.row(pos_row).default_format = format
    sheet1.row(pos_row).set_format(0, format)
    sheet1.row(pos_row).push 'NOMBRE DEL DEPARTAMENTO O DISTRITO: ' + Institucion.find(current_user.institucion_id).name
    pos_row += 1
    sheet1.row(pos_row).push '','','AÑO:' + Time.now.year.to_s
    sheet1.merge_cells(pos_row,2,pos_row,13)
    pos_row += 1
    sheet1.row(pos_row).push 'EQUIPO','SERIAL','ENERO','FEBRERO','MARZO','ABRIL',
                                  'MAYO','JUNIO','JULIO','AGOSTO','SEPTIEMBRE','OCTUBRE',
                                    'NOVEMBRE','DICIEMBRE','MANTENIMIENTO PREVENTIVOS PROGRAMDOS',
                                      'MANTENIMIENTO PREVENTIVOS REALIZADOS', 'OBSERVACIONES'

    @consulta.each do |fila|
      pos_row += 1
      sheet1.row(pos_row).push  fila.category.nombre + " " + fila.marca.nombre + " " +fila.modelo.nombre,fila.serial,
      verify_month(1,fila.mantenimiento),verify_month(2,fila.mantenimiento),
      verify_month(3,fila.mantenimiento),verify_month(4,fila.mantenimiento),
      verify_month(5,fila.mantenimiento),verify_month(6,fila.mantenimiento),
      verify_month(7,fila.mantenimiento),verify_month(8,fila.mantenimiento),
      verify_month(9,fila.mantenimiento),verify_month(10,fila.mantenimiento),
      verify_month(11,fila.mantenimiento),verify_month(12,fila.mantenimiento),
      fila.mantenimiento.man_programados,fila.mantenimiento.man_realizados,fila.mantenimiento.observaciones

    end

    pos_row += 1
    sheet1.row(pos_row).push ''
    pos_row += 1
    sheet1.merge_cells(pos_row,0,pos_row,16)
    sheet1.row(pos_row).push 'DATOS DEL CONTRATO'
    sheet1.row(pos_row).set_format(0, format)
    pos_row += 1
    if (@responsable)
      sheet1.row(pos_row).push 'FECHA DE FIRMA DEL CONTRATO:','','','','','',@responsable.mantenimiento.fecha_firma.to_s
      sheet1.merge_cells(pos_row,0,pos_row,5)
      pos_row += 1
      sheet1.row(pos_row).push 'VIGENCIA DEL CONTRATO:','','','','','',@responsable.mantenimiento.fecha_vigencia.to_s
      sheet1.merge_cells(pos_row,0,pos_row,5)
      pos_row += 1
      sheet1.row(pos_row).push 'NOMBRE DEL SUPERVISOR DEL CONTRATO:','','','','','',@responsable.mantenimiento.supervisor.to_s
      sheet1.merge_cells(pos_row,0,pos_row,5)
      pos_row += 1
      sheet1.row(pos_row).push 'CARGO DEL SUPERVISOR DEL CONTRATO:','','','','','',@responsable.mantenimiento.cargo_supervisor.to_s
      sheet1.merge_cells(pos_row,0,pos_row,5)
    else
      sheet1.row(pos_row).push 'INGRESE INFORMACION DE MANTENIMIENTO EN CUARTOS FRIOS O NEVERAS PARA GENERAR'
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
        metodo = "fecha_man" + i.to_s
        fecha = fila.send(metodo)
        if fecha

          if fecha.mon === mes
          return 'X'
          end
        end
      end
      ''
    end

    def set_mantenimiento
      @mantenimiento = Mantenimiento.find(params[:id])
    end

    def mantenimiento_params
      params.require(:mantenimiento).permit(:man_programados, :man_realizados, :observaciones, :fecha_firma, :fecha_vigencia, :supervisor,:cargo_supervisor,:fecha_man1,:fecha_man2,:fecha_man3,:fecha_man4,:fecha_man5,:fecha_man6,:fecha_man7,:fecha_man8,:fecha_man9,:fecha_man10,:fecha_man11,:fecha_man12)
    end
end
