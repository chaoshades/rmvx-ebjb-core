#==============================================================================
# ** Control
#------------------------------------------------------------------------------
#  Represents basic components of a control on a window
#==============================================================================

class Control
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Window in which the control will be drawn
  attr_reader   :window
  # Sprite in which the control will be drawn
  attr_reader   :sprite
  # Control activity
  attr_accessor :active
  # Control visibility
  attr_accessor :visible
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get bitmap in which the control will be drawn
  #--------------------------------------------------------------------------
  # GET
  def bitmap
    # Refresh bitmap from the window since the window can decide to dispose it
    # (ex.: Window_Selectable when drawing the items)
    if @bitmap.disposed? && @window != nil
      @bitmap = @window.contents
    end
    return @bitmap
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, active, visible)
    if window.is_a?(Bitmap)
      @bitmap = window
    elsif window.is_a?(Sprite)
      @sprite = window
      @bitmap = window.bitmap
    else
      @window = window
      @bitmap = window.contents
    end
    @active = active
    @visible = visible
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update bitmap size
  #     width : new width
  #     height : new height
  #--------------------------------------------------------------------------
  def update_bitmap_size(width, height)
    @bitmap = Bitmap.update_bitmap_size(@bitmap, width, height)
    if @window != nil
      @window.contents = @bitmap
    elsif @sprite != nil
      @sprite.bitmap = @bitmap
    end
  end
  
end
