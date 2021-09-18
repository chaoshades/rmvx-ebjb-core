#==============================================================================
# ** Sub_Scene_Base
#------------------------------------------------------------------------------
#  This is a superclass of all sub_scenes (reusable scenes) in the game
#==============================================================================

class Sub_Scene_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # True if the sub scene can be closed, else false
  # (can inform the main scene that the sub scene can be closed, for example,
  #  when there are no windows that are active in the sub scene)
  attr_reader :isClosable
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Start Processing (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def start
  end
  
  #--------------------------------------------------------------------------
  # * Termination Processing (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def terminate
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def update 
  end
  
  #--------------------------------------------------------------------------
  # * Show windows (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def show_windows
  end
  
  #--------------------------------------------------------------------------
  # * Hide windows (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def hide_windows
  end
  
end
