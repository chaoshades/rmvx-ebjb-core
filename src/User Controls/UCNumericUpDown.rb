#==============================================================================
# ** UCNumericUpDown
#------------------------------------------------------------------------------
#  Represents a NumericUpDown user control on a window
#==============================================================================

class UCNumericUpDown < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control to show the value
  attr_reader   :cLabelNumber
  # Value of the user control
  attr_reader   :value
  # Pattern used to format the value
  attr_accessor :pattern
  # Minimum value of the user control
  attr_accessor :min
  # Maximum value of the user control
  attr_accessor :max
  # Step used for the operations Up/Down of the user control
  attr_accessor :step
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cLabelNumber.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabelNumber.active = active
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the user control
  #     value : value of the user control
  #     pattern : pattern to use to format the value
  #     min : minimum value of the user control
  #     max : maximum value of the user control
  #     step : step used for the operations Up/Down of the user control
  #     align : text alignment
  #     font : font of the value
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, value, pattern=nil, min=0, max=99, step=1, align=0, 
                 font=nil, active=true, visible=true)
    super(active, visible)
    @cLabelNumber = CLabel.new(window, rect, nil, align, font)
    @cLabelNumber.active = active
    @cLabelNumber.visible = visible
    @value = value
    self.pattern = pattern
    self.min = min
    self.max = max
    self.step = step
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the NumericUpDown on the window
  #--------------------------------------------------------------------------
  def draw()
    if (self.pattern != nil)
      @cLabelNumber.text = sprintf(self.pattern, @value.to_s)
    else
      @cLabelNumber.text = @value.to_s
    end
    @cLabelNumber.draw()
  end
  
  #--------------------------------------------------------------------------
  # * Up operation of the NumericUpDown
  #--------------------------------------------------------------------------
  def up()
    if @value < self.max
      @value = [@value + self.step, self.max].min
    end
    #@cLabelNumber.text = sprintf(@pattern, @value.to_s)
  end
  
  #--------------------------------------------------------------------------
  # * Down operation of the NumericUpDown
  #--------------------------------------------------------------------------
  def down()
    if @value > self.min
      @value = [@value - self.step, self.min].max
    end
    #@cLabelNumber.text = sprintf(@pattern, @value.to_s)
  end
  
  #--------------------------------------------------------------------------
  # * Reset operation of the NumericUpDown
  #--------------------------------------------------------------------------
  def reset()
    @value = self.min
  end
  
end
