#==============================================================================
# ** CRectangle
#------------------------------------------------------------------------------
#  Represents a Rectangle control on a window
#==============================================================================

class CRectangle < Control
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Rectangle to position the control
  attr_accessor :rect
  # Fill color 1 of the control
  attr_accessor :color1
  # Fill color 2 of the control (used for gradient) 
  attr_accessor :color2
  # True to have a vertical gradient, else false
  attr_accessor :vertical
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     rect : rectangle to position the control
  #     color1 : fill color 1 of the control
  #     color2 : fill color 2 of the control (used for gradient) 
  #     vertical : true to have a vertical gradient, else false
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, color1, color2=color1, vertical=false, 
                 active=true, visible=true)
    super(window, active, visible)
    self.rect = rect
    self.color1 = color1
    self.color2 = color2
    self.vertical = vertical
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible     
      c1 = self.color1
      c2 = self.color2
      gradient = c1 != c2
      if !active
        if gradient
          c1 = Color.inactive_gauge_color1
          c2 = Color.inactive_gauge_color2
        else
          c1 = c2 = Color.gauge_back_color
        end
      end
      
      if gradient
        bitmap.gradient_fill_rect(rect.x, rect.y, rect.width, 
                                           rect.height, c1, c2, self.vertical)
      else
        bitmap.fill_rect(rect.x, rect.y, rect.width, rect.height, c1)
      end
    end
  end
  
end
