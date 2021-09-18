#==============================================================================
# ** ArmorFilter
#------------------------------------------------------------------------------
#  Represents an Armor filter
#==============================================================================

class ArmorFilter < BaseItemFilter
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method
  #     x : object to filter
  #--------------------------------------------------------------------------
  alias apply_baseArmorFilter_ebjb apply unless $@    
  def apply(x)
    if x != nil && x.is_a?(RPG::Armor)
       
      case mode
        when "kind"
          return applyKind(x)
        #when
          #...
        else
          return apply_baseArmorFilter_ebjb(x)
      end
      
    else
      return nil
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method (using the kind property)
  #--------------------------------------------------------------------------
  def applyKind(x)
    if x.kind == @value
      return true
    else
      return false
    end
  end
  private:applyName
  
end
