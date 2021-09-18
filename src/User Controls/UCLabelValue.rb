#==============================================================================
# ** UCLabelValue
#------------------------------------------------------------------------------
#  Represents a pair of Label controls (label/value) on a window
#==============================================================================

class UCLabelValue < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control "Label"
  attr_reader   :cLabel
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
    @cValue.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabel.active = active
    @cValue.active = active
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rectLabel : rectangle to position the Label control "Label"
  #     rectValue : rectangle to position the Label control "Value"
  #     label : content in the Label control "Label"
  #     value : content in the Label control "Value"
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rectLabel, rectValue, label, value, active=true, 
                 visible=true)
    super(active, visible)
    @cLabel = CLabel.new(window, rectLabel, label)
    @cLabel.active = active
    @cLabel.visible = visible
    @cValue = CLabel.new(window, rectValue, value)
    @cValue.active = active
    @cValue.visible = visible  
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the label and the value on the window
  #--------------------------------------------------------------------------
  def draw()
    @cLabel.draw()
    @cValue.draw()
  end
  
end
