#==============================================================================
# ** UCImageBorder
#------------------------------------------------------------------------------
#  Represents an Image control with a border on a window
#==============================================================================

class UCImageBorder < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control
  attr_reader   :cImage
  # Rectangle controls that forms the border of the Image control
  attr_reader   :cBorders
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cImage.visible = visible
    @cBorders.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cImage.active = active
    @cBorders.active = active
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     rect : rectangle to position the control
  #     bitmap : bitmap object containing the image to show
  #     src_rect : rectangle of the image to get in the bitmap
  #     align : image alignment
  #     opacity : image opacity
  #     valign : image vertical alignment
  #     border : size of the border
  #     border_color : border color
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, bitmap, src_rect, align=0, opacity=255, 
                 valign=0, border=0, border_color=nil,
                 active=true, visible=true)
    super(active, visible)
    
    if border > 0 && !border_color.nil?
      vertices = [[rect.x, rect.y],[rect.x+rect.width, rect.y],
                  [rect.x+rect.width, rect.y+rect.height],
                  [rect.x, rect.y+rect.height]]
      @cBorders = CPolygon.new(window, vertices, nil, false, nil,
                               border, border_color)
      rect = Rect.new(rect.x + border, rect.y + border, 
                      rect.width - border*2, rect.height - border*2)
    end
    
    @cImage = CImage.new(window, rect, bitmap, src_rect, align, opacity, valign)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the image and border on the window
  #--------------------------------------------------------------------------
  def draw()
    if !@cBorders.nil?
      @cBorders.draw()
    end
    @cImage.draw()
  end
  
end
