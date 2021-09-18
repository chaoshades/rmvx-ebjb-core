#==============================================================================
# ** UCLabelIconControlsSwitchableList
#------------------------------------------------------------------------------
#  Represents a list of UCLabelIcon controls on a window. The latter switch
#  after some time when there are more user controls than the space available
#  in the rectangle that position it to show the other user controls
#==============================================================================

class UCLabelIconControlsSwitchableList < UCControlsSwitchableList
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////

  #--------------------------------------------------------------------------
  # * Draw the switchable UCLabelIcon
  #-------------------------------------------------------------------------- 
  def draw_switchable(control, index)
    labelRect = control.cLabel.rect
    control.cLabel.rect = Rect.new(@rectControls.x + index*labelRect.width,
                                   labelRect.y, labelRect.width, labelRect.height)
    control.ucIcon.cIcon.rect = Rect.new(@rectControls.x + index*24,
                                         @rectControls.y, 24, 24)
    control.draw()
  end
  private :draw_switchable
  
  #--------------------------------------------------------------------------
  # * Clear the controls
  #-------------------------------------------------------------------------- 
  def clear_switchable()
    for i in 0 .. @ucControls.size-1
      if !@ucControls[i].cLabel.rect.nil?
        @ucControls[i].cLabel.bitmap.clear_rect(@ucControls[i].cLabel.rect)
      end
      if !@ucControls[i].ucIcon.cIcon.rect.nil?
        @ucControls[i].ucIcon.cIcon.bitmap.clear_rect(@ucControls[i].ucIcon.cIcon.rect)
      end
    end
  end
  private :clear_switchable
  
end
