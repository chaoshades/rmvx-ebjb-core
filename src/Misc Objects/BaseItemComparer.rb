#==============================================================================
# ** BaseItemComparer
#------------------------------------------------------------------------------
#  Represents a BaseItem comparer
#==============================================================================

class BaseItemComparer < Comparer
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Compare method
  #     x : first object to compare
  #     y : second object to compare
  #--------------------------------------------------------------------------
  def compare(x,y)
    if x != nil && x.is_a?(RPG::BaseItem) &&
       y != nil && y.is_a?(RPG::BaseItem)
       
      case mode
        when "name"
          return compareName(x,y)
        when "type"
          return compareType(x,y)
        #when
          #...
        else
          return 0
      end
      
    else
      return nil
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Compare method (using the name property)
  #     x : first object to compare
  #     y : second object to compare
  #--------------------------------------------------------------------------
  def compareName(x,y)
    if x.name < y.name
      result = -1
    elsif x.name > y.name
      result = 1
    elsif x.name == y.name
      result = 0
    end
    
    # Switch when in descendant order
    case @order
    when 1
      result *= -1     
    end
    
    return result
  end
  private:compareName
  
  #--------------------------------------------------------------------------
  # * Compare method (using the type of the object)
  #     x : first object to compare
  #     y : second object to compare
  #--------------------------------------------------------------------------
  def compareType(x,y)
    # This will produce this result :
    #   UsableItems
    #   Weapons
    #   Armors
    if (x.is_a?(RPG::UsableItem) && y.is_a?(RPG::Weapon)) ||
       (x.is_a?(RPG::Weapon) && y.is_a?(RPG::Armor))
      result = -1
    elsif (x.is_a?(RPG::Weapon) && y.is_a?(RPG::UsableItem)) ||
          (x.is_a?(RPG::Armor) && y.is_a?(RPG::Weapon))
      result = 1
    elsif (x.is_a?(RPG::UsableItem) && y.is_a?(RPG::UsableItem)) ||
          (x.is_a?(RPG::Weapon) && y.is_a?(RPG::Weapon)) ||
          (x.is_a?(RPG::Armor) && y.is_a?(RPG::Armor))
      result = 0
    end
    
    # Switch when in descendant order
    case @order
    when 1
      result *= -1     
    end
    
    return result
  end
  private:compareType
  
end
