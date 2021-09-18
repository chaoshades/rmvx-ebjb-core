#==============================================================================
# ** SkillFilter
#------------------------------------------------------------------------------
#  Represents a Skill filter
#==============================================================================

class SkillFilter < UsableItemFilter
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method
  #     x : object to filter
  #--------------------------------------------------------------------------
  alias apply_baseSkillFilter_ebjb apply unless $@  
  def apply(x)
    if x != nil && x.is_a?(RPG::Skill)
       
      case mode
        when "healing"
          return applyHealing(x)
        when "support"
          return applySupport(x)
        when "attack"
          return applyAttack(x)
        #when
          #...
        else
          return apply_baseSkillFilter_ebjb(x)
      end
      
    else
      return nil
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method (using the base_damage property)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applyHealing(x)
    if (x.base_damage < 0) == @value
      return true
    else
      return false
    end
  end
  private:applyHealing
  
  #--------------------------------------------------------------------------
  # * Apply method (using the plus_state_set && base_damage property)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applySupport(x)
    if ((x.minus_state_set.length > 0 || x.plus_state_set.length > 0) && 
        x.base_damage == 0) == @value
      return true
    else
      return false
    end
  end
  private:applySupport
  
  #--------------------------------------------------------------------------
  # * Apply method (using the applyHealing && applySupport methods)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applyAttack(x)
    if (applyHealing(x) == !@value && applySupport(x) == !@value)
      return true
    else
      return false
    end
  end
  private:applyAttack
  
end
