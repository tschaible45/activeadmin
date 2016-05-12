ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
     columns do
       column do
         panel "Recent Posts" do
           ul do
             Product.available.map do |product|
               li link_to(product.title, admin_product_path(product)) + " - " + product.category.name
             end
           end
         
         end
       end

       column do
         panel "Order Info" do
           #para "Welcome to ActiveAdmin."
             ul do
                 Order.in_progress.map do |order|
                     #li link_to(order.line_items.product, admin_order_path(order)) #order.line_items.product
                     li link_to(order.id, admin_order_path(order)) #order.line_items.product
                end
            end
         end
       end
       
       column do
           panel "Overdue Request" do
           #para "Overdue Requests"
           ul do
               Request.Overdue.map do |req|
                   li link_to(req.title, admin_request_path(req)) + " - " + req.status
               end
           end
       end
   end
     end
  end # content
end
