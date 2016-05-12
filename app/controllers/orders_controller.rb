class OrdersController < ApplicationController
    before_filter :update_price      #, only: [:edit, :update]
    
    def index
        @orders = Order.all
    end
    
    def new
        @order.recalculate_price!
    end
    
    def show
        @order = Order.find(params[:id])
    end
    
    def update
         @order = Order.find(params[:id])
         @order.total_price = 100.0
         self.recalculate_price!
    end 
    
    private
    
        def update_price
             @order.recalculate_price!
        end
    
end