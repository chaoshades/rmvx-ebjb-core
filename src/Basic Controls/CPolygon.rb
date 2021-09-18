#==============================================================================
# ** CPolygon
#------------------------------------------------------------------------------
#  Represents a Polygon control on a window
#==============================================================================

class CPolygon < CDrawingObject

  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Vertices to draw the polygon
  attr_accessor :vertices
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the polygon will be drawn
  #     vertices : vertices to draw the polygon
  #     color1 : fill color 1 of the polygon
  #     filled : true to draw a filled polygon, else false
  #     color2 : fill color 2 of the polygon (used for gradient) 
  #     border : size of the border
  #     br_color1 : border color 1 of the polygon
  #     br_color2 : border color 2 of the polygon (used for gradient) 
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, vertices, color1, filled=true, color2=color1, 
                 border=0, br_color1=color1, br_color2=br_color1,
                 active=true, visible=true)
    super(window, color1, filled, color2, 
          border, br_color1, br_color2, 
          active, visible)
    self.vertices = vertices
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
        bitmap.draw_filled_polygon(self.vertices, c1, c2)
      end

      if border > 0
        bitmap.draw_polygon(self.vertices, br_c1, self.border, br_c2)
      end

    end

  end
  
  #--------------------------------------------------------------------------
  # * Translate the polygon on the window
  #     x : x value to translate the vertices
  #     y : y value to translate the vertices
  #--------------------------------------------------------------------------
  def translate(x, y)
    for v in self.vertices
      #x component
      v[0] += x
      #y component
      v[1] += y
    end
  end
  
end
