#==============================================================================
# ** CDrawingObject
#------------------------------------------------------------------------------
#  Represents basic components for a drawing object on a window
#==============================================================================

class CDrawingObject < Control

  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Fill color 1 of the object
  attr_accessor :color1
  # Fill color 2 of the object (used for gradient) 
  attr_accessor :color2
  # Size of the border
  attr_accessor :border
  # Border color 1 of the object
  attr_accessor :br_color1
  # Border color 2 of the object (used for gradient) 
  attr_accessor :br_color2
  # True to draw a filled object, else false
  attr_accessor :filled
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the object will be drawn
  #     color1 : fill color 1 of the object
  #     filled : true to draw a filled object, else false
  #     color2 : fill color 2 of the object (used for gradient) 
  #     border : size of the border
  #     br_color1 : border color 1 of the object
  #     br_color2 : border color 2 of the object (used for gradient) 
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, color1, filled=true, color2=color1, 
                 border=0, br_color1=color1, br_color2=color1,
                 active=true, visible=true)
    super(window, active, visible)
    self.color1 = color1
    self.color2 = color2
    self.filled = filled
    self.border = border
    self.br_color1 = br_color1
    self.br_color2 = br_color2
  end
  
end
