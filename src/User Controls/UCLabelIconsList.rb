#==============================================================================
# ** UCLabelIconsList
#------------------------------------------------------------------------------
#  Represents a Label control with a list of Icon user controls on a window
#==============================================================================

class UCLabelIconsList < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control
  attr_reader :cLabel
  # List of Icon user controls
  attr_reader :ucIcons
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Window in which the user control will be drawn 
  @window = nil
  # Rectangle to position the Icon user controls
  @rectIcons = nil
  # Array containing the icon indexes to show in Icon user controls
  @icons = nil

  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get & Set the icons array that will be drawn
  #--------------------------------------------------------------------------
  # GET
  def icons()
    return @icons 
  end
  # SET
  def icons=(icons)
    @ucIcons = []
    if (icons != nil)
      for i in 0 .. icons.size-1
        @ucIcons[i] = UCIcon.new(@window, @rectIcons, icons[i])
        @ucIcons[i].active = @active
        @ucIcons[i].visible = @visible
      end
    end
    @icons = icons 
  end
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cLabel.visible = visible
    for i in 0 .. @ucIcons.size-1
      @ucIcons[i].visible = visible
    end
  end
  
  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabel.active = active
    for i in 0 .. @ucIcons.size-1
      @ucIcons[i].active = active
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rectLabel : rectangle to position the Label control
  #     rectIcons : rectangle to position the Icon user controls
  #     label : content in the Label control 
  #     icons : array containing the icon indexes to show in Icon user controls
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rectLabel, rectIcons, label, icons, active=true, 
                 visible=true)
    super(active, visible)
    @cLabel = CLabel.new(window, rectLabel, label)
    @cLabel.active = active
    @cLabel.visible = visible
    @window = window
    @rectIcons = rectIcons
    self.icons = icons
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the label and the icons on the window
  #-------------------------------------------------------------------------- 
  def draw()
    @cLabel.draw()
    draw_icons()
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the icons
  #-------------------------------------------------------------------------- 
  def draw_icons()
    for i in 0 .. @ucIcons.size-1
      @ucIcons[i].cIcon.rect = Rect.new(@rectIcons.x + i*24, @rectIcons.y, 24, 24)
      @ucIcons[i].draw()
    end
  end
  private :draw_icons
  
end
