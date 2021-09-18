#==============================================================================
# ** ItemComparer
#------------------------------------------------------------------------------
#  Represents an Item comparer
#==============================================================================

class ItemComparer < BaseItemComparer
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Compare method
  #     x : first object to compare
  #     y : second object to compare
  #--------------------------------------------------------------------------
  alias compare_baseItemComparer_ebjb compare unless $@
  def compare(x,y)
    if x != nil && x.is_a?(RPG::Item) &&
       y != nil && y.is_a?(RPG::Item)
       
      case mode
        when "price"
          return comparePrice(x,y)
        #when
          #...
        else
          return compare_baseItemComparer_ebjb(x,y)
      end
      
    else
      return nil
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Compare method (using the price of the object)
  #     x : first object to compare
  #     y : second object to compare
  #--------------------------------------------------------------------------
  def comparePrice(x,y)
    if x.price < y.price
      result = -1
    elsif x.price > y.price
      result = 1
    elsif x.price == y.price
      result = 0
    end
    
    # Switch when in descendant order
    case @order
    when 1
      result *= -1     
    end
    
    return result
  end
  private:comparePrice
  
end
