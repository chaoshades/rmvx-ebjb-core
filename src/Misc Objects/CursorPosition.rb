#==============================================================================
# ** CursorPosition
#------------------------------------------------------------------------------
#  Represents a CursorPosition object for the Window_Custom_Selectable window
#==============================================================================

class CursorPosition
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Rectangle of the cursor position
  attr_accessor :rect
  # True if the position is enabled, else false
  attr_accessor :enabled
    
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     rect : rectangle of the cursor position
  #     enabled : true if the position is enabled, else false
  #--------------------------------------------------------------------------
  def initialize(rect, enabled=true)
    self.rect = rect
    self.enabled = enabled
  end
  
end
