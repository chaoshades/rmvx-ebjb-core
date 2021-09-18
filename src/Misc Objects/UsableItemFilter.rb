#==============================================================================
# ** UsableItemFilter
#------------------------------------------------------------------------------
#  Represents an UsableItem filter
#==============================================================================

class UsableItemFilter < BaseItemFilter
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method
  #     x : object to filter
  #--------------------------------------------------------------------------
  alias apply_baseUsableItemFilter_ebjb apply unless $@
  def apply(x)
    if x != nil && x.is_a?(RPG::UsableItem)
       
      case mode
        when "physical_attack"
          return applyPhysicalAttack(x)
        #when
          #...
        else
          return apply_baseUsableItemFilter_ebjb(x)
      end
      
    else
      return nil
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method (using the physical_attack property)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applyPhysicalAttack(x)
    if x.physical_attack == @value
      return true
    else
      return false
    end
  end
  private:applyPhysicalAttack
  
end
