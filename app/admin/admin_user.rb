ActiveAdmin.register AdminUser do
    
    permit_params :email, :password
    
    form do |f|
      f.inputs 'Administrator' do
        f.input :email
        f.input :password
        f.input :password_confirmation
      end
      f.button :Submit
    end

    index do
      column :email
      column :last_sign_in_at
      column :last_sign_in_ip
      actions
    end
  end
