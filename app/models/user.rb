class User < ActiveRecord::Base
  before_save { self.role ||= :standard }
  after_initialize self.role = :standard
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  enum role: [:standard, :premium, :admin]       
end
