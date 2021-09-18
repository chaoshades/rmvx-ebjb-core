#==============================================================================
# ** TestUI_SubScene
#------------------------------------------------------------------------------
#  Unit tests for the suc scene
#==============================================================================

class TestUI_SubScene < TestUI_Class
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Setup tests
  #--------------------------------------------------------------------------
  def testFixtureSetup()
    @windows = []
    # setup your objects for the tests (if needed)
  end
  
  #--------------------------------------------------------------------------
  # * Tear down tests
  #--------------------------------------------------------------------------
  def testFixtureTearDown()
    for w in @windows
      w.dispose
    end
    @windows = nil
    # destroy your objects when the tests are finished (if needed)
  end
  
  #--------------------------------------------------------------------------
  # * Frame update
  #--------------------------------------------------------------------------
  def update()
    for w in @windows
      w.update
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Tests
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Sub_Scene by default
  #--------------------------------------------------------------------------
  def test_default
    return true
  end
  
end

# Custom classes for testing purpose of Sub_Scene_Base
class Sub_Scene_Implemented < Sub_Scene_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    @isClosable = false
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
    super

    @skill_details_window = Window_SkillDetails.new(0,384,640,96, nil)
    @skill_details_window.visible = false
    @enemy_skills_window.detail_window = @skill_details_window
    
    @help_window = Window_Info_Help.new(0, 384, 640, 96, nil)
    @help_window.visible = false
    
    @enemy_skills_window.help_window = @help_window
    
  end
  
  #--------------------------------------------------------------------------
  # * Termination Processing
  #--------------------------------------------------------------------------
  def terminate
    super
    
    unless @bg.nil?
      @bg.bitmap.dispose
      @bg.dispose
    end
    @enemy_skills_window.dispose if @enemy_skills_window != nil
    @skill_details_window.dispose if @skill_details_window != nil
    @help_window.dispose if @help_window != nil
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    @enemy_skills_window.update
    @skill_details_window.update
    @help_window.update
    @command_window.update
    
  end
  
  #--------------------------------------------------------------------------
  # * Update windows
  #--------------------------------------------------------------------------
  def windows_update(gameEnemy)
    @isClosable = false
    # Return to initial state when the enemy changes
    @command_window.index = 0
    cancel_command()
       
    @enemy_skills_window.window_update(gameEnemy.enemy, scan_mode)
  end
  
  #--------------------------------------------------------------------------
  # * Show windows
  #--------------------------------------------------------------------------
  def show_windows
    super
    @enemy_skills_window.visible = true
    @enemy_skills_window.active = false
  end
  
  #--------------------------------------------------------------------------
  # * Hide windows
  #--------------------------------------------------------------------------
  def hide_windows
    super
    @enemy_skills_window.visible = false
    @enemy_skills_window.active = false
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #//////////////////////////////////////////////////////////////////////////
  # * Scene input management methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update Command Selection
  #--------------------------------------------------------------------------
  def update_command_selection()
    if Input.trigger?(Input::B)
      Sound.play_cancel
      quit_command()
     
    elsif Input.trigger?(Input::C)
      case @command_window.index
      when 0  # Notes
        Sound.play_decision
        notes_command()
      when 1  # Skills
        Sound.play_decision
        skills_command()
      when 2  # Drops
        Sound.play_decision
        drops_command()
        update_detail_window(@enemy_drops_window.selected_item)
      end
    end
    
  end
  private :update_command_selection
  
  #//////////////////////////////////////////////////////////////////////////
  # * Scene Commands
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Cancel command
  #--------------------------------------------------------------------------
  def cancel_command()
    @command_window.active = true
    @skill_details_window.window_update(nil)
    @skill_details_window.visible = false
    @help_window.window_update("")
    @help_window.active = false
    @help_window.visible = false
  end
  private :cancel_command
  
  #--------------------------------------------------------------------------
  # * Quit command
  #--------------------------------------------------------------------------
  def quit_command()
    @command_window.active = false
    @isClosable = true
  end
  private :quit_command
  
  #--------------------------------------------------------------------------
  # * Notes command
  #--------------------------------------------------------------------------
  def notes_command()
    @command_window.active = false
    @enemy_image_window.active = true
    @enemy_image_window.call_update_help()
    @help_window.visible = true
    @help_window.active = true
  end
  private :notes_command
  
end

class Scene_Test_Sub_Scene < Scene_Base

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(menu_index = nil)
    @menu_index = menu_index
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Start processing
  #--------------------------------------------------------------------------
  def start
    super
    create_menu_background()
    
    @subScene = Sub_Scene_Implemented.new
    @subScene.start()
    @subScene.windows_update($data_items)
    @subScene.show_windows()
  end
  
  #--------------------------------------------------------------------------
  # * Termination Processing
  #--------------------------------------------------------------------------
  def terminate
    super
    dispose_menu_background()
    
    @subScene.terminate if @subScene != nil
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    update_menu_background()
    
    @subScene.update
    
    if @subScene.isClosable 
      quit_command()
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Return scene
  #--------------------------------------------------------------------------
  def return_scene
    if @menu_index != nil
      $scene = Scene_Menu.new(@menu_index)
    else
      $scene = Scene_Map.new
    end
  end
  private :return_scene
  
  #//////////////////////////////////////////////////////////////////////////
  # * Scene Commands
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Quit command
  #--------------------------------------------------------------------------
  def quit_command()
    return_scene
  end
  private :quit_command
  
end

class Scene_Menu < Scene_Base
  include EBJB
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Alias create_command_window
  #--------------------------------------------------------------------------
  alias create_command_window_ebjb create_command_window unless $@
  def create_command_window
    # Keeps the selected index and cancel the @menu_index
    # (because in the original create_command_window, 
    # this line is called after the creation of the window :
    #   @command_window.index = @menu_index
    # and with a command that doesn't exist, the index will be invalid)
    temp_index = @menu_index
    @menu_index = -1
    create_command_window_ebjb
    @command_sub_scene = @command_window.add_command("Sub Scene Test")
    # Finally, apply the index when all the necessary commands are added
    @command_window.index = temp_index
  end
  
  #--------------------------------------------------------------------------
  # * Alias update_command_selection
  #--------------------------------------------------------------------------
  alias update_command_selection_ebjb update_command_selection unless $@
  def update_command_selection
    if Input.trigger?(Input::C)
      case @command_window.index
      when @command_sub_scene
        Sound.play_decision
        $scene = Scene_Test_Sub_Scene.new(@command_window.index)
      end
    end
    update_command_selection_ebjb
  end
  
end

