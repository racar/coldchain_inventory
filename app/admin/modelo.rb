ActiveAdmin.register Modelo do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

permit_params :nombre, :category_id, :marca_id

form do |f|
  f.inputs do
    f.input :nombre
    f.input :category_id
    f.input :marca_id

  end
  f.actions
end

end
