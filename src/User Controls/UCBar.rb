#==============================================================================
# ** UCBar
#------------------------------------------------------------------------------
#  Represents a Bar user control on a window
#==============================================================================

class UCBar < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Rectangle control to position the Bar user control
  attr_reader   :cRectangle
  # Rectangle control that fill the Bar user control
  attr_reader   :cFillRectangle
  # Rectangle control that forms the border of the Bar user control
  attr_reader   :cBorder
  # Current value (to fill the rectangle)
  attr_accessor :value
  # Maximum value (to have a filled rectangle)
  attr_accessor :max_value
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cRectangle.visible = visible
    @cFillRectangle.visible = visible
    if !@cBorder.nil?
      @cBorder.visible = visible
    end
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cRectangle.active = active
    @cFillRectangle.active = active
    if !@cBorder.nil?
      @cBorder.active = active
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the user control
  #     color1 : fill color 1 of the user control
  #     color2 : fill color 2 of the user control (used for gradient) 
  #     back_color : back color of the user control
  #     value : current value (to fill the rectangle)
  #     max_value : maximum value (to reach to have a filled rectangle)
  #     border : size of the border
  #     border_color : border color
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, color1, color2, back_color, value, max_value,
                 border=0, border_color=nil, active=true, visible=true)
    super(active, visible)
    self.value = value
    self.max_value = max_value
    
    if border > 0 && !border_color.nil?
      border_rect = Rect.new(rect.x, rect.y, rect.width, rect.height)
      @cBorder = CRectangle.new(window, border_rect, border_color)
      rect = Rect.new(rect.x + border, rect.y + border, rect.width - border*2, rect.height - border*2)
    end
    
    @cRectangle = CRectangle.new(window, rect, back_color)
    gradient_rect = Rect.new(rect.x, rect.y, rect.width, rect.height)
    @cFillRectangle = CRectangle.new(window, gradient_rect, color1, color2)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the bar on the window
  #--------------------------------------------------------------------------
  def draw()
    if !@cBorder.nil?
      @cBorder.draw()
    end
    @cRectangle.draw()
    
    value = self.value
    if (value == nil)
      value = 0
    end
    max = self.max_value
    if (max == nil)
      max = value
    end
    if (max == 0)
      max = 1
    end
    gw = @cRectangle.rect.width * value / max
    
    @cFillRectangle.rect.width = gw
    @cFillRectangle.draw()
  end
  
end
