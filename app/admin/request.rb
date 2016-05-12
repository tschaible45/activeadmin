ActiveAdmin.register Request do


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
  permit_params :category_id, :title, :phase, :priority, :effort, :status, :date_opened, :commit_date, :closed_date, :related_kb, :assigned_to, :comments, :user, :user_id, :customer_id
  #column("Customer", :user, :sortable => :user_id)
  
  form do |f|
    f.semantic_errors
    f.inputs "Request Details" do
        
        f.input :title, :wrapper_html => { :class => "important" }, :required => true
        f.input :category_id, as: :select, collection: Category.available, :required => true
        #f.inputs :for => :categories do |category, i|
        #end
        #f.inputs :name => 'Category #%i', :for => :categories
        f.input :phase, as: :select, collection: Request.PHASES #["Research","Design","Evaluation","Implemented"]
        f.input :priority,  :as => :radio, collection: Request.Priorities
        f.input :effort,  :input_html => { :style => 'width:10%'}
        f.input :status, as: :select, collection: Request.STATUS
        f.input :date_opened, as: :datepicker, datepicker_options: { min_date: "2013-10-8",        max_date: "+3D" }, :input_html =>  { :style => 'width:10%'}
        f.input :commit_date, as: :datepicker, datepicker_options: { min_date: "2013-10-8",        max_date: "+3D" }, :input_html =>  { :style => 'width:10%'}
        f.input :assigned_to, as: :select, collection: User.Active
        f.input :user, as: :select, collection: User.all
        #f.semantic_fields_for :user do |user|
        #  user.inputs :username, :email, :name => "User"
        #end
        f.input :closed_date,  as: :datepicker, datepicker_options: { min_date: "2013-10-8",        max_date: "+3D" }, :input_html =>  { :style => 'width:10%'}
        f.input :customer_id, as: :select, collection: User.Active 
        #f.inputs :user, :for => :customer, :name =>"Customer"
        f.input :comments, as: :text
    end
      f.actions do 
       f.action :submit
       f.action :cancel
      end
  end
  
  index do
    column("Request", :sortable => :id) {|req| link_to "##{req.id} ", admin_request_path(req) }
    column("Title", :title, :sortable => :title)  
    column("Phase", :phase)
    column("Category", :category, :sortable => :category)
    column("Priority", :priority)
    column("Owner", :user)
    column("Date Opened", :date_opened)
    column("Status", :status)
    #column :us_citizen, Proc.new {|obj| obj.us_citizen? ? 'Yes' : 'No'}
    column("Days Open", :days_open) do |days|
      days.status !='Closed' ? Date.today - days.date_opened : 0
    end
    column("Overdue", :status) do |od|
      od.status !='Closed' && od.commit_date.nil? ? status_tag( "yes", :error) : status_tag("no")
    #end
    #column(:published) do |story| 
    #story.published? ? status_tag( "yes", :ok ) : status_tag( "no" )
    
  end
  end
end