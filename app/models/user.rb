require 'digest/sha1'

class User < ActiveRecord::Base
  
  # Gives the user a gravatar_url method
  include Gravtastic
  is_gravtastic! 
  
  has_secure_password
  
  # Restrict attributes allowed to be modified on creation
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_many :players
  has_many :scores, :through => :players
  has_many :games, :through => :scores
  
  has_many :league_memberships
  has_many :leagues, :through => :league_memberships
  has_many :owned_leagues, :class_name => 'League', :foreign_key => :owner_id 
  
  validates_confirmation_of :password  
  validates_presence_of :password, :on => :create  
  validates_presence_of :email  
  validates_uniqueness_of :email
  validates_length_of :name, :minimum => 1
  
end
