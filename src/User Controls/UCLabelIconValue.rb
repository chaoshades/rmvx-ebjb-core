#==============================================================================
# ** UCLabelIconValue
#------------------------------------------------------------------------------
#  Represents a pair of Label controls (label/value) and an Icon user control 
#  on a window
#==============================================================================

class UCLabelIconValue < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control "Label"
  attr_reader   :cLabel
  # Icon user control
  attr_reader   :ucIcon
  # Label control "Value"
  attr_reader   :cValue
  
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
    @cValue.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabel.active = active
    @ucIcon.active = active
    @cValue.active = active
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rectLabel : rectangle to position the Label control "Label"
  #     rectIcon : rectangle to position the Icon user control
  #     rectLabel : rectangle to position the Label control "Value"
  #     label : content in the Label control "Label"
  #     iconIndex : index of the icon to show in the Icon user control
  #     value : content in the Label control "Value"
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rectLabel, rectIcon, rectValue, label, iconIndex, value,
                 active=true, visible=true)
    super(active, visible)
    @cLabel = CLabel.new(window, rectLabel, label)
    @cLabel.active = active
    @cLabel.visible = visible
    @ucIcon = UCIcon.new(window, rectIcon, iconIndex)
    @ucIcon.active = active
    @ucIcon.visible = visible
    @cValue = CLabel.new(window, rectValue, value)
    @cValue.active = active
    @cValue.visible = visible
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
    @cValue.draw()
  end
  
end
