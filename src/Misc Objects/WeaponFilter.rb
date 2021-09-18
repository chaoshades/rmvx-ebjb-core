#==============================================================================
# ** WeaponFilter
#------------------------------------------------------------------------------
#  Represents a Weapon filter
#==============================================================================

class WeaponFilter < BaseItemFilter
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method
  #     x : object to filter
  #--------------------------------------------------------------------------
  alias apply_baseWeaponFilter_ebjb apply unless $@  
  def apply(x)
    if x != nil && x.is_a?(RPG::Weapon)
       
      case mode
        when "two_handed"
          return applyTwoHanded(x)
        #when
          #...
        else
          return apply_baseWeaponFilter_ebjb(x)
      end
      
    else
      return nil
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method (using the two_handed property)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applyTwoHanded(x)
    if x.two_handed == @value
      return true
    else
      return false
    end
  end
  private:applyTwoHanded
  
end
