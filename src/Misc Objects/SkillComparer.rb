#==============================================================================
# ** SkillComparer
#------------------------------------------------------------------------------
#  Represents a Skill comparer
#==============================================================================

class SkillComparer < BaseItemComparer
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Compare method
  #     x : first object to compare
  #     y : second object to compare
  #--------------------------------------------------------------------------
  alias compare_baseSkillComparer_ebjb compare unless $@
  def compare(x,y)
    if x != nil && x.is_a?(RPG::Skill) &&
       y != nil && y.is_a?(RPG::Skill)
       
      case mode
        when "mp_cost"
          return compareMpCost(x,y)
        #when
          #...
        else
          return compare_baseSkillComparer_ebjb(x,y)
      end
      
    else
      return nil
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Compare method (using the mp_cost of the object)
  #     x : first object to compare
  #     y : second object to compare
  #--------------------------------------------------------------------------
  def compareMpCost(x,y)
    if x.mp_cost < y.mp_cost
      result = -1
    elsif x.mp_cost > y.mp_cost
      result = 1
    elsif x.mp_cost == y.mp_cost
      result = 0
    end
    
    # Switch when in descendant order
    case @order
    when 1
      result *= -1     
    end
    
    return result
  end
  private:compareMpCost
  
end
