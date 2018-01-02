

AdminUser.delete_all
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
=begin
Municipio.delete_all
File.open("#{Rails.root}/db/municipios.txt") do |municipios|
  municipios.read.each_line do |municipio|
    name, region, area, pob = municipio.chomp.split("|")
    Municipio.create!(:name => name, :region => region)
  end
end

Institucion.delete_all
User.delete_all
File.open("#{Rails.root}/db/instituciones.txt") do |instituciones|
  instituciones.read.each_line do |institucion|
    name_mun, name = institucion.chomp.split("|")
    id_mun = Municipio.find_by_name(name_mun).id
    #puts id_mun
    #Institucion.create!(:name => name, :caracter => caracter, :tipo => tipo :municipio_id => id_mun,:cod_habilita => cod_habilita )
    @inst = Institucion.create!(:name => name, :municipio_id => id_mun)
    User.create([{institucion_id: @inst.id, name: 'user'+@inst.id.to_s, email: 'demo'++@inst.id.to_s+'@demo.com', password: "user_password", remember_created_at: nil }])

  end
end

#User.delete_all
#User.create([{ name: 'racar', email: 'demo@demo.com', password: "change_me", remember_created_at: nil }])


Category.delete_all
#Category.create!(:nombre => "NO REGISTRA", :id => 0)
File.open("#{Rails.root}/db/categorias.txt") do |categorias|
  categorias.read.each_line do |categoria|
    nombre, id = categoria.chomp.split("|")
    Category.create!(:nombre => nombre)
  end
end

Marca.delete_all
Marca.create!(:nombre => "NO REGISTRA", :category_id => 0, :id => 0)
File.open("#{Rails.root}/db/marcas.txt") do |marcas|
  marcas.read.each_line do |marca|
    nombre, categoria = marca.chomp.split("|")

    @cat = Category.where(["nombre = ? ", categoria]).first
    Marca.create!(:nombre => nombre, :category_id => @cat.id)
  end
end

Modelo.delete_all
Modelo.create!(:nombre => "NO REGISTRA", :category_id => 0, :marca_id => 0, :id => 0)
File.open("#{Rails.root}/db/modelos.txt") do |modelos|
  modelos.read.each_line do |modelo|
    categoria,marca,nombre = modelo.chomp.split("|")

    @cat = Category.where(["nombre = ? ", categoria]).first
    cat = 0
    if @cat
      cat = @cat.id
    end

    @mar = Marca.where(["nombre = ? ", marca]).first
    mar = 0
    if @mar
      mar = @mar.id
    end
    Modelo.create!(:nombre => nombre, :category_id => cat, :marca_id => mar)
  end
end
=end
