#==============================================================================
# ** ItemFilter
#------------------------------------------------------------------------------
#  Represents an Item filter
#==============================================================================

class ItemFilter < UsableItemFilter
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method
  #     x : object to filter
  #--------------------------------------------------------------------------
  alias apply_baseItemFilter_ebjb apply unless $@
  def apply(x)
    if x != nil && x.is_a?(RPG::Item)
       
      case mode
        when "healing"
          return applyHealing(x)
        when "support"
          return applySupport(x)
        when "growth"
          return applyGrowth(x)
        when "attack"
          return applyAttack(x)
        #when
          #...
        else
          return apply_baseItemFilter_ebjb(x)
      end
      
    else
      return nil
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method (using the hp/mp_recovery, hp/mp_recovery_rate property)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applyHealing(x)
    if (x.base_damage < 0 || 
        x.hp_recovery > 0 || x.hp_recovery_rate > 0 ||
        x.mp_recovery > 0 || x.mp_recovery_rate > 0) == @value
      return true
    else
      return false
    end
  end
  private:applyHealing
  
  #--------------------------------------------------------------------------
  # * Apply method (using the minus/plus_state_set, hp/mp_recovery, 
  #                 hp/mp_recovery_rate property)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applySupport(x)
    if ((x.minus_state_set.length > 0 || x.plus_state_set.length > 0) && 
        x.base_damage == 0 && 
        x.hp_recovery == 0 && x.hp_recovery_rate == 0 &&
        x.mp_recovery == 0 && x.mp_recovery_rate == 0) == @value
      return true
    else
      return false
    end
  end
  private:applySupport
  
  #--------------------------------------------------------------------------
  # * Apply method (using the parameter_type property)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applyGrowth(x)
    if (x.parameter_type != 0) == @value
      return true
    else
      return false
    end
  end
  private:applyGrowth
  
  #--------------------------------------------------------------------------
  # * Apply method (using the applyHealing && applySupport methods)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applyAttack(x)
    if (applyHealing(x) == !@value && applySupport(x) == !@value &&
        applyGrowth(x) == !@value)
      return true
    else
      return false
    end
  end
  private:applyAttack
  
end
