#==============================================================================
# ** UCLabelIconsSwitchableList
#------------------------------------------------------------------------------
#  Represents a Label control with a list of Icon user controls on a window. The 
#  latter switch after some time when there are more icons than the space 
#  available in the rectangle that position it to show the other icons
#==============================================================================

class UCLabelIconsSwitchableList < UCControlsSwitchableList

  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control
  attr_reader :cLabel
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Window in which the user control will be drawn 
  @window = nil
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
    @ctrFrames = 0
    @ucControls = []
    if (icons != nil)
      for i in 0 .. icons.size-1
        @ucControls[i] = UCIcon.new(@window, @rectControls, icons[i])
        @ucControls[i].active = @active
        @ucControls[i].visible = @visible
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
    super
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabel.active = active
    super
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
  #     number : number of icons to show
  #     timeout : timeout used (in milliseconds) to switch between icons
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rectLabel, rectIcons, label, icons, 
                 number, timeout, active=true, visible=true)
    super(rectIcons, nil, number, timeout, active, visible)
    @window = window
    self.icons = icons
    @cLabel = CLabel.new(window, rectLabel, label)
    @cLabel.active = active
    @cLabel.visible = visible
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the label and the icons on the window
  #-------------------------------------------------------------------------- 
  def draw()
    super
    @cLabel.draw()
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////

  #--------------------------------------------------------------------------
  # * Draw the switchable icons
  #-------------------------------------------------------------------------- 
  def draw_switchable(control, index)
    control.cIcon.rect = Rect.new(@rectControls.x + index*24,
                                  @rectControls.y, 24, 24)
    control.draw()
  end
  private :draw_switchable
  
  #--------------------------------------------------------------------------
  # * Clear the controls
  #-------------------------------------------------------------------------- 
  def clear_switchable()
    for i in 0 .. @ucControls.size-1
      if !@ucControls[i].cIcon.rect.nil?
        @ucControls[i].cIcon.bitmap.clear_rect(@ucControls[i].cIcon.rect)
      end
    end
  end
  private :clear_switchable
    
end
