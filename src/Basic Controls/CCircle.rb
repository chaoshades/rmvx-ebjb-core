#==============================================================================
# ** CCircle
#------------------------------------------------------------------------------
#  Represents a Circle control on a window
#==============================================================================

class CCircle < CDrawingObject
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Coordinates (X,Y) of the center of the circle
  attr_accessor :x, :y
  # Radius of the circle
  attr_accessor :radius
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the circle will be drawn
  #     x : center of the circle X coordinate
  #     y : center of the circle Y coordinate
  #     radius : radius of the circle
  #     color1 : fill color 1 of the circle
  #     filled : true to draw a filled circle, else false
  #     color2 : fill color 2 of the circle (used for gradient) 
  #     border : size of the border
  #     br_color1 : border color 1 of the circle
  #     br_color2 : border color 2 of the circle (used for gradient) 
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, x, y, radius, color1, filled=true, color2=color1, 
                 border=0, br_color1=color1, br_color2=br_color1,
                 active=true, visible=true)
    super(window, color1, filled, color2, 
          border, br_color1, br_color2, 
          active, visible)
    self.x = x
    self.y = y
    self.radius = radius
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
      br_c1 = self.br_color1
      br_c2 = self.br_color2
      gradient = (c1 != c2)
      br_gradient = (br_c1 != br_c2)
      if !active
        if gradient
          c1 = Color.inactive_gauge_color1
          c2 = Color.inactive_gauge_color2
        else
          c1 = c2 = Color.gauge_back_color
        end
        
        if br_gradient
          br_c1 = Color.inactive_gauge_color1
          br_c2 = Color.inactive_gauge_color2
        else
          br_c1 = br_c2 = Color.normal_color
        end
      end
      
      if filled
        bitmap.draw_filled_circle(self.x, self.y, self.radius, c1, c2)
      end
      
      if border > 0
        bitmap.draw_circle(self.x, self.y, self.radius, br_c1, self.border, br_c2)
      end
      
    end
  end
  
end
