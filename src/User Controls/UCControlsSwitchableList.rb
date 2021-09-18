#==============================================================================
# ** UCControlsSwitchableList
#------------------------------------------------------------------------------
#  Represents a list of controls on a window that switch after some time when 
#  there are more controls than the space available in the rectangle 
#  that position it to show the other controls
#==============================================================================

class UCControlsSwitchableList < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # List of controls
  attr_reader :ucControls
  # Rectangle to position the controls
  attr_reader :rectControls
  # Timeout used (in milliseconds) to switch between controls
  attr_reader :timeout
  # Number of controls to show
  attr_accessor :number
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Frames counter to switch controls
  @ctrFrames = 0
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set the timeout before switching between controls
  #--------------------------------------------------------------------------
  def timeout=(timeout)
    @timeout = timeout.to_f/1000 * 60
  end
  
  #--------------------------------------------------------------------------
  # * Set the controls array that will be drawn
  #--------------------------------------------------------------------------
  # SET
  def controls=(controls)
    @ctrFrames = 0
    @ucControls = []
    if (controls != nil)
      for i in 0 .. controls.size-1
        @ucControls[i] = controls[i]
        @ucControls[i].active = @active
        @ucControls[i].visible = @visible
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    for i in 0 .. @ucControls.size-1
      @ucControls[i].visible = visible
    end
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    for i in 0 .. @ucControls.size-1
      @ucControls[i].active = active
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     rectControls : rectangle to position the controls
  #     controls : array containing the controls
  #     number : number of controls to show
  #     timeout : timeout used (in milliseconds) to switch between controls
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(rectControls, controls, number, timeout, 
                 active=true, visible=true)
    super(active, visible)
    @rectControls = rectControls
    @ctrFrames = 0
    if controls != nil
      self.controls = controls
    end
    @number = number
    self.timeout = timeout
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw a batch of controls depending on the number to show 
  #-------------------------------------------------------------------------- 
  def draw()
    draw_controls()
  end

  #--------------------------------------------------------------------------
  # * Frame Update
  #-------------------------------------------------------------------------- 
  def update()
    clear_switchable()
    draw_controls()
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////

  #--------------------------------------------------------------------------
  # * Draw controls
  #-------------------------------------------------------------------------- 
  def draw_controls()
    startControlPos = (@ctrFrames / self.timeout).to_i * self.number
    if (startControlPos >= @ucControls.size)
      @ctrFrames = 0
      startControlPos = 0
    end

    for i in startControlPos .. startControlPos + self.number-1
      if @ucControls[i] != nil
        draw_switchable(@ucControls[i], i-startControlPos)
      end
    end
    @ctrFrames +=1
  end
  private :draw_controls
  
  #--------------------------------------------------------------------------
  # * Draw the control (contents are defined by the subclasses)
  #     control : control to draw
  #     index : index to position the control
  #-------------------------------------------------------------------------- 
  def draw_switchable(control, index)
  end
  private :draw_switchable
  
  #--------------------------------------------------------------------------
  # * Clear the controls (contents are defined by the subclasses)
  #-------------------------------------------------------------------------- 
  def clear_switchable()
  end
  private :clear_switchable
  
end
