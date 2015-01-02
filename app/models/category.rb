class Category < ActiveRecord::Base
  
  validates :name, :presence => true
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  has_many :parts , :dependent => :destroy

  def done_parts
     parts.where(:done => true).order("updated_at DESC")
  end
  
end
