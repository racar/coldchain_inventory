ActiveAdmin.register Marca do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :nombre, :category_id

 form do |f|
   f.inputs do
     f.input :nombre
     f.input :category_id

   end
   f.actions
 end
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
