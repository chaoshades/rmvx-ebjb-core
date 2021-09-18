#===============================================================================
# ** RPG::Element
#------------------------------------------------------------------------------
#  Data class for element. 
#===============================================================================

class RPG::Element
  include EBJB
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Element ID
  attr_accessor :id
  # Element name
  attr_accessor :name
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get icon_index of the element
  #--------------------------------------------------------------------------
  # GET
  def icon_index()
    return CORE_CONFIG::ELEMENT_ICONS[self.id] 
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    @id = 0
    @name = ""
    @icon_index = 0
  end
  
end