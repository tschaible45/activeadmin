ActiveAdmin.register User, :as => "Customer" do

  menu :priority => 4
  config.batch_actions = true
  permit_params  :username, :email, :active, :password, :password_confirmation, :password_salt, :password_hash
  filter :username
  filter :email
  filter :created_at
  controller do
    def permitted_params
      params.permit!
      #permit_params :username, :email, :password
    end
    
    end
 
  form do |f|
    f.semantic_errors
    f.inputs "Customer Details" do
        f.input :username
        f.input :email
        #f.input :password
        #f.input :password_confirmation
        f.input :active
        if f.object.new_record?
            f.input :password
            f.input :password_confirmation
        end
    end
       f.actions do 
        f.action :submit
        f.action :cancel
      end
  end
  
  index do
    selectable_column
    id_column
    column :username
    column :email
    column :active
    column :created_at
    actions
  end

  show :title => :username do
    panel "Order History" do
      table_for(customer.orders) do
        column("Order", :sortable => :id) {|order| link_to "##{order.id}", admin_order_path(order) }
        column("State")                   {|order| status_tag(order.state) }
        column("Date", :sortable => :checked_out_at){|order| pretty_format(order.checked_out_at) }
        column("Total")                   {|order| number_to_currency order.total_price }
      end
    end
  end

  sidebar "Customer Details", :only => :show do
    attributes_table_for customer, :username, :email, :created_at
  end

  sidebar "Order History", :only => :show do
    attributes_table_for customer do
      row("Total Orders") { customer.orders.complete.count }
      row("Total Value") { number_to_currency customer.orders.complete.sum(:total_price) }
    end
  end

  sidebar "Active Admin Demo" do
    render('/admin/sidebar_links', :model => 'users')
  end
end
