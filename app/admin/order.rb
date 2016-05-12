ActiveAdmin.register Order do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?:
  #   permitted
  # end
  menu parent: "Customers"
  #menu :priority => 3
  #actions :index, :show, :new, :edit
  permit_params :user_id, :checked_out_at, :state, :total_price, :product_id, line_items_attributes: [:product_id, :id, :price], line_item_ids: [], product_attributes: []
  filter :total_price
  filter :checked_out_at

  scope :all, :default => true
  scope :in_progress
  scope :complete
  
  form do |f|
    f.inputs "Order Details" do
        f.input :user
        f.input :checked_out_at,  as: :datepicker, datepicker_options: { min_date: "2013-10-8",        max_date: "+3D" }
        f.input :total_price
        f.inputs "Product(s)" do
          f.has_many :line_items, heading: false do |i|
            i.input :product, as: :select, collection: Product.all
            i.input :price, :for => :line_items
           
          #f.input :line_items,  as: :select, collection: Product.all
          # f.input :order_id, :for => :line_items
          # f.input :line_item.product, as: :select, collection: Product.all
          #f.inputs "Dates" do
          #f.has_many :class_dates
          #cd.input :start_time, :as => :datetime_picker
          end
        end
    end
      f.actions do 
       f.action :submit
       f.action :cancel
      end
  end
        
  index do
    column("Order", :sortable => :id) {|order| link_to "##{order.id} ", admin_order_path(order) }
    column("State")                   {|order| status_tag(order.state) }
    column("Date", :checked_out_at)
    column("Customer", :user, :sortable => :user_id)
    column("Total")                   {|order| number_to_currency order.total_price }
    column("CheckedOut", :checked_out_at)
  end

  show do
    panel "Invoice" do
      table_for(order.line_items) do |t|
        t.column("Product") {|item| auto_link item.product        }
        t.column("Price")   {|item| number_to_currency item.price }
        tr :class => "odd" do
          td "Total:", :style => "text-align: right;"
          td number_to_currency(order.total_price)
        end
      end
    end
   
  end

  sidebar :customer_information, :only => :show do
    attributes_table_for order.user do
      row("User") { auto_link order.user }
      row :email
    end
  end

  sidebar "Active Admin Demo" do
    render('/admin/sidebar_links', :model => 'orders')
  end
end
