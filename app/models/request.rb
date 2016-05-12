class Request < ActiveRecord::Base
    belongs_to :category
    belongs_to :user
    #belongs_to :customer
    
    #scope :all, :default => true
    scope :PHASES, -> {["Concept","Design","Evaluation","Implemented","Research","Road Map","Unassigned"]}
    scope :STATUS, -> {["Open","Closed","In-progress","Deferred"]}
    scope :Active, -> {where("status != ?",'Closed')}
    scope :Priorities, -> {["1","2","3"]}
    scope :Overdue, lambda{ where("commit_date < ?", Date.today) }
    
    
    validates_presence_of :title
    validates_presence_of :category
    
    def is_overdue
       self.commit_date.nil? ? false : true
    end 
    
    def days_overdue
       self.commit_date.nil? ? 0 : (Date.today - self.date_opened)
    end
    
    def days_open
       self.status != 'Closed' ? Date.today - self.date_opened : 0
    end
end
