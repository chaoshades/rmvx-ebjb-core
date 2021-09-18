#==============================================================================
# ** UCIcon
#------------------------------------------------------------------------------
#  Represents an Icon user control on a window
#==============================================================================

class UCIcon < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control to draw the icon
  attr_reader :cIcon
  # Icon index
  attr_accessor :iconIndex
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cIcon.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cIcon.active = active
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the Image control
  #     iconIndex : index of the Icon to draw
  #     align : icon image alignment
  #     opacity : icon image opacity
  #     valign : icon image vertical alignment
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, iconIndex, align=0, opacity=255, valign=0, 
                 active=true, visible=true)
    super(active, visible)
    self.iconIndex = iconIndex
    @cIcon = CImage.new(window, rect, nil, nil, align, opacity, valign, 
                        active, visible)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the icon on the window
  #--------------------------------------------------------------------------
  def draw()
    if self.iconIndex != nil
      bitmap = Cache.system("IconSet")
      @cIcon.img_bitmap = bitmap
      @cIcon.src_rect = Rect.new(self.iconIndex % 16 * 24, self.iconIndex / 16 * 24, 
                        24, 24)
      @cIcon.draw()
    end
  end
  
end
