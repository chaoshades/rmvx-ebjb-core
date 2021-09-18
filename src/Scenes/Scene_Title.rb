#==============================================================================
# ** Scene_Title
#------------------------------------------------------------------------------
#  This class performs the title screen processing.
#==============================================================================

class Scene_Title < Scene_Base
  
  #--------------------------------------------------------------------------
  # * Alias load_database
  #--------------------------------------------------------------------------
  alias load_database_ebjb load_database unless $@
  def load_database
    load_database_ebjb
    
    $data_elements = load_elements($data_system.elements)
    $data_system.elements = $data_elements
  end
  
  #--------------------------------------------------------------------------
  # * Alias load_bt_database
  #--------------------------------------------------------------------------
  alias load_bt_database_ebjb load_bt_database unless $@
  def load_bt_database
    load_bt_database_ebjb

    $data_elements = load_elements($data_system.elements)
    $data_system.elements = $data_elements
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////

  #--------------------------------------------------------------------------
  # * Load the elements data from the system data elements property
  #     system_elements : array of elements from the system data
  #--------------------------------------------------------------------------
  def load_elements(system_elements)
    data_elements = [nil]
    for i in 1 .. system_elements.size-1
      element = RPG::Element.new()
      element.id = i
      element.name = system_elements[i]
      data_elements[i] = element
    end
    
    return data_elements
  end
  private:load_elements
  
end
