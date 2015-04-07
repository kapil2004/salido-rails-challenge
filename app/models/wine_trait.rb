class WineTrait < ActiveRecord::Base
  
  belongs_to :wine
  belongs_to :trait
  
end