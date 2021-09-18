#==============================================================================
# ** CTriangle
#------------------------------------------------------------------------------
#  Represents a Triangle control on a window
#==============================================================================

class CTriangle < CDrawingObject

  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # First coordinates (X,Y) of the triangle
  attr_accessor :x1, :y1
  # Second coordinates (X,Y) of the triangle
  attr_accessor :x2, :y2
  # Third coordinates (X,Y) of the triangle
  attr_accessor :x3, :y3
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the triangle will be drawn
  #     x1 : first triangle X coordinate
  #     y1 : first triangle Y coordinate
  #     x2 : second triangle X coordinate
  #     y2 : second triangle Y coordinate
  #     x3 : third triangle X coordinate
  #     y3 : third triangle Y coordinate
  #     color1 : fill color 1 of the triangle
  #     filled : true to draw a filled triangle, else false
  #     color2 : fill color 2 of the triangle (used for gradient) 
  #     border : size of the border
  #     br_color1 : border color 1 of the triangle
  #     br_color2 : border color 2 of the triangle (used for gradient) 
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, x1, y1, x2, y2, x3, y3, color1, filled=true, 
                 color2=color1, border=0, br_color1=color1, br_color2=br_color1,
                 active=true, visible=true)
    super(window, color1, filled, color2, 
          border, br_color1, br_color2, 
          active, visible)
    self.x1 = x1
    self.y1 = y1
    self.x2 = x2
    self.y2 = y2
    self.x3 = x3
    self.y3 = y3
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
      
      vertices = [[self.x1,self.y1], [self.x2,self.y2], [self.x3,self.y3]]
      
      if filled
        bitmap.draw_filled_polygon(vertices, c1, c2)
      end
      
      if border > 0
        bitmap.draw_polygon(vertices, br_c1, self.border, br_c2)
      end
    end
  end

  #--------------------------------------------------------------------------
  # * Translate the triangle on the window
  #     x : x value to translate the coordinates
  #     y : y value to translate the coordinates
  #--------------------------------------------------------------------------
  def translate(x, y)
    self.x1 += x
    self.y1 += y
    self.x2 += x 
    self.y2 += y
    self.x3 += x 
    self.y3 += y 
  end
  
end
