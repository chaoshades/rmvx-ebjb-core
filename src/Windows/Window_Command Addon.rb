#==============================================================================
# ** Window_Command Addon
#------------------------------------------------------------------------------
#  Addon function for add, insert & remove in a Window_Command
#
#  Based on KGC script to add commands
#  Credits to KGC
#==============================================================================

class Window_Command < Window_Selectable
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Add command
  #     command : command to add
  #     resize : resize flag to resize window
  #--------------------------------------------------------------------------
  def add_command(command, resize=true)
    @commands << command
    @item_max = @commands.size
    item_index = @item_max - 1
    refresh_command(resize)
    return item_index
  end
  
  #--------------------------------------------------------------------------
  # * Insert command
  #     index : index to add the command
  #     command : command to add
  #     resize : resize flag to resize window
  #--------------------------------------------------------------------------
  def insert_command(index, command, resize=true)
    @commands.insert(index, command)
    @item_max = @commands.size
    refresh_command(resize)
  end
  
  #--------------------------------------------------------------------------
  # * Remove command
  #     command : command to remove
  #     resize : resize flag to resize window
  #--------------------------------------------------------------------------
  def remove_command(command, resize=true)
    @commands.delete(command)
    @item_max = @commands.size
    refresh_command(resize)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Refresh command
  #     resize : resize flag to resize window
  #--------------------------------------------------------------------------
  def refresh_command(resize)
    if resize
      self.height = [self.height, row_max * WLH + 32].max
    end
    create_contents
    refresh
  end
  private :refresh_command
  
end
