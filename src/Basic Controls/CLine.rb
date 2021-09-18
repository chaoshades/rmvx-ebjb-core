#==============================================================================
# ** CLine
#------------------------------------------------------------------------------
#  Represents a Line control on a window
#==============================================================================

class CLine < Control
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # First coordinates (X,Y) of the line
  attr_accessor :x1, :y1
  # Second coordinates (X,Y) of the line
  attr_accessor :x2, :y2
  # Fill color 1 of the object
  attr_accessor :color1
  # Line width
  attr_accessor :width
  # Fill color 2 of the object (used for gradient) 
  attr_accessor :color2
  # True to have a vertical gradient, else false
  attr_accessor :vertical
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the line will be drawn
  #     rect : rectangle to position the line
  #     x1 : first line X coordinate
  #     y1 : first line Y coordinate
  #     x2 : second line X coordinate
  #     y2 : second line Y coordinate
  #     color1 : fill color 1 of the line
  #     width : line width
  #     color2 : fill color 2 of the line (used for gradient) 
  #     vertical : true to have a vertical gradient, else false
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, x1, y1, x2, y2, color1, width=1, color2=color1, vertical=false,
                 active=true, visible=true)
    super(window, active, visible)
    self.x1 = x1
    self.y1 = y1
    self.x2 = x2
    self.y2 = y2
    self.width = width
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

      bitmap.draw_line(self.x1, self.y1, self.x2, self.y2, 
                                  c1, self.width, c2, self.vertical)

    end
  end

end
