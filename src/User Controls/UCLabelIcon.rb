#==============================================================================
# ** UCLabelIcon
#------------------------------------------------------------------------------
#  Represents a Label with an Icon user control on a window
#==============================================================================

class UCLabelIcon < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Instance Variables
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control
  attr_reader :cLabel
  # Icon user control
  attr_reader :ucIcon
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cLabel.visible = visible
    @ucIcon.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabel.active = active
    @ucIcon.active = active
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rectLabel : rectangle to position the Label control
  #     rectIcon : rectangle to position the Icon user control
  #     label : content in the Label control 
  #     iconIndex : index of the icon to show in the Icon user control
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rectLabel, rectIcon, label, iconIndex, active=true,
                 visible=true)
    super(active, visible)
    @cLabel = CLabel.new(window, rectLabel, label)
    @cLabel.active = active
    @cLabel.visible = visible
    @ucIcon = UCIcon.new(window, rectIcon, iconIndex)
    @ucIcon.active = active
    @ucIcon.visible = visible
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the label and the icon on the window
  #--------------------------------------------------------------------------
  def draw()
    @ucIcon.draw()
    @cLabel.draw()
  end
  
end
