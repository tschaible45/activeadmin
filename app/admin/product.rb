ActiveAdmin.register Product do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  menu :priority => 2
  permit_params :title,:description,:author,:price, :featured, :available_on,:image_file_name,:category_id
  
  scope :all, :default => true
  scope :available do |products|
    products.where("available_on < ?", Date.today)
  end
  scope :drafts do |products|
    products.where("available_on > ?", Date.today)
  end
  scope :featured_products do |products|
    products.where(:featured => true)
  end

 # index :as => :grid do |product|
 #   div do
 #     
 #     a :href => admin_product_path(product) do
 #       image_tag("products/" + product.image_file_name)
 #       
 #     end
 #     
 #   end
   
 #   a truncate(product.title), :href => admin_product_path(product)
    
 #  end

  #show :title => :title

  sidebar :product_stats, :only => :show do
    attributes_table_for resource do
      row("Total Sold")  { Order.find_with_product(resource).count }
      row("Dollar Value"){ number_to_currency LineItem.where(:product_id => resource.id).sum(:price) }
    end
  end

  sidebar :recent_orders, :only => :show do
    Order.find_with_product(resource).limit(5).collect do |order|
      auto_link(order)
    end.join(content_tag("br")).html_safe
  end

  sidebar "Active Admin Demo" do
    render('/admin/sidebar_links', :model => 'products')
  end

end
