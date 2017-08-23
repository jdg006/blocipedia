class User < ActiveRecord::Base
  before_save { self.role ||= :standard }
  has_many :collaborators
  has_many :wikis, through: :collaborators
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  enum role: [:standard, :premium, :admin]   
  
end
