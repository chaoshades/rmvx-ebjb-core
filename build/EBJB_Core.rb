################################################################################
#                           EBJB Core - EBJB_Core                     #   VX   #
#                          Last Update: 2012/03/15                    ##########
#                         Creation Date: 2011/05/22                            #
#                          Author : ChaosHades                                 #
#     Source :                                                                 #
#     http://www.google.com                                                    #
#------------------------------------------------------------------------------#
#  Contains common functions and objects for different uses in the EBJB        #
#  scripts. You can use them as well for your needs.                           #
#==============================================================================#
#                         ** Instructions For Usage **                         #
#  There are settings that can be configured in the Core_Config class. For     #
#  more info on what and how to adjust these settings, see the documentation   #
#  in the class.                                                               #
#==============================================================================#
#                                ** Examples **                                #
#  See the documentation in each classes.                                      #
#==============================================================================#
#                           ** Installation Notes **                           #
#  Copy this script in the Materials section                                   #
#==============================================================================#
#                             ** Compatibility **                              #
#  Overwrites: Window_Selectable - initialize, index, create_contents, top_row #
#                                  page_row_max, cursor_down, cursor_up,       #
#                                  cursor_left, cursor_right, cursor_pagedown, #
#                                  cursor_pageup, item_rect, update_cursor,    #
#                                  update                                      #
#  Alias: Window_Selectable - call_update_help, cursor_movable?                #
################################################################################

$imported = {} if $imported == nil
$imported["EBJB_Core"] = true

#==============================================================================
# ** CORE_CONFIG
#------------------------------------------------------------------------------
#  Contains the Core configuration
#==============================================================================

module EBJB
  module CORE_CONFIG

    #--------------------------------------------------------------------------
    # - Bitmap text drawing constants -
    #--------------------------------------------------------------------------
    
    # End of line character
    END_LINE_CHARACTER = "\r\n"
    # Line separator 
    # (ex.: multi-
    #       line)
    LINE_SEPARATOR = "-"
    # Character used for cutting text 
    # (ex.: toolongte...)
    CUT_OVERFLOW_CHARACTER = "..."
    # Default line height
    LINE_HEIGHT = 24
    
    #--------------------------------------------------------------------------
    # - Details window related -
    #--------------------------------------------------------------------------
    
    # Icons used for the Elemental Resistance Graph and the Elements icons list
    #0 = None           5 = Bow   (no)    10 = Ice    (105) 15 = Holy     (110) 
    #1 = Melee    (no)  6 = Whip  (no)    11 = Thunder(106) 16 = Darkness (111)
    #2 = Percing  (no)  7 = Mind  (no)    12 = Water  (107)
    #3 = Slashing (no)  8 = Absorb (no)   13 = Earth  (108)  
    #4 = Blow  (no)     9 = Fire   (104)  14 = Wind   (109)   
    ELEMENT_ICONS = [0,0,0,0,0,0,0,0,0,104,105,106,107,108,109,110,111]
    
    # Default icons used for the Scope stat in the Scope icons list
    #0 = None                  4 = One Random Enemy  (129)  8 = All Allies  (130)  
    #1 = One Enemy   (157)     5 = 2 Random Enemies  (129)  9 = One Dead Ally (112)
    #2 = All Enemies (135)     6 = 3 Random Enemies  (129)  10 = All Dead Allies (112)
    #3 = One Enemy Dual (157)  7 = One Ally          (130)   11 = The User (159)
    DEFAULT_SCOPE_ICONS = [0,157,135,157,129,129,129,130,130,112,112,159]
    
    # Default icons used for the Occasion stat in the Scope icons list
    #0 = Always (101)               2 = Only from the Menu (153) 
    #1 = Only in Battle (131)       3 = Never (145) 
    DEFAULT_OCCASION_ICONS = [101,131,153,145]
    
    # Default icons used for the Bonus stat in the Bonus icons list
    #0 = Two Handed (50)             2 = Prevent Critical (52) 
    #1 = Critical Bonus  (119)       3 = Half MP Cost (133) 
    DEFAULT_BONUS_ICONS = [50,119,52,133]

    # Default number of icons to show at the same time
    DEFAULT_MAX_ICONS = 4
    # Default timeout in milliseconds before switching icons
    DEFAULT_ICONS_TIMEOUT = 1000

    # Default pattern used to show the value of the Recovery effect
    DEFAULT_REC_PATTERN = "%d%%+%d"
    # Default sign for plus state set
    DEFAULT_STATES_PLUS_SIGN = "+"
    # Default sign for minus state set
    DEFAULT_STATES_MINUS_SIGN = "-"
    
  end
end

#--------------------------------------------------------------------------
# The following settings are Y6 Core Engine settings. 
# They have been moved here to ease configuration. 
# For complete documentation, see the Y6 Core Engine script above.
#--------------------------------------------------------------------------
module Y6
  module SETTING
    
    #--------------------------------------------------------------------------
    # - Resize Screen Width and Height -
    #--------------------------------------------------------------------------
    # RPG Maker VX has the option of having larger width and height for your
    # games. Resizing the width and height will have the following changes:
    # 
    #              Default   Resized   Min Tiles Default   Min Tiles New
    #    Width       544       640           17                 20
    #    Height      416       480           13                 15
    # 
    # * Note: Maximum width is 640 while maximum height is 480.
    #         Minimum width is 110 while maximum height is 10.
    #         These are limitations set by RPG Maker VX's engine.
    # 
    # By selecting resize, all of the default menus will have their windows
    # adjusted, but scripts provided by non-Yanfly Engine sources may or may
    # not adjust themselves properly.
    #--------------------------------------------------------------------------
    RESIZE_WIDTH  = 640
    RESIZE_HEIGHT = 480
    
    #--------------------------------------------------------------------------
    # - Change Default Font -
    #--------------------------------------------------------------------------
    # This allows you to change the default font if that's what you wish to do
    # with your game. This array orders the fonts by priority. If the player
    # lacks the font in the front of the array, the game will skip that font
    # and choose the next available font in line.
    # 
    # Default Fonts: ["Verdana", "Arial", "Courier New"]
    #--------------------------------------------------------------------------
    DEFAULT_FONT_NAME = ["Verdana", "Arial", "Courier New"]
    DEFAULT_FONT_SIZE = 18       # Changes the size of the text. Default - 20
    DEFAULT_FONT_BOLD = false    # Changes default state of text bolding. Default - FALSE
    DEFAULT_FONT_ITALIC = false  # Changes default state of italic text. Default - FALSE
    DEFAULT_FONT_SHADOW = true   # Changes the showing of text shadowing. Default - TRUE
    
    #--------------------------------------------------------------------------
    # - Text Outlining -
    #--------------------------------------------------------------------------
    # The way text shadows are displayed in RPG Maker VX makes it difficult to
    # see. Text outlining replaces the shadow, but provides an outline around
    # text to make it more visible. Turning off shadows in the font settings
    # will make outlines disappear as well if this setting is enabled.
    #--------------------------------------------------------------------------
    OUTLINE = false
    
    #--------------------------------------------------------------------------
    # - Digit Grouping -
    #--------------------------------------------------------------------------
    # Setting this to true will cause numbers to be grouped together when they
    # are larger than a thousand. For example, 12345 will appear as 12,345.
    #--------------------------------------------------------------------------
    GROUP_DIGITS = true
    
    #--------------------------------------------------------------------------
    # - Help Window Upgrade -
    #--------------------------------------------------------------------------
    # This determines what will be displayed when using \n[0] in a description
    # and no main actor is present.
    #--------------------------------------------------------------------------
    HELP_WINDOW_0 = "User"
 
    
# *****************************************************************************
# COLOR SETTINGS ARE OVERRIDED BY EBJB ENGINE, see Color class
# *****************************************************************************
#~     #--------------------------------------------------------------------------
#~     # - Window Colour Settings -
#~     #--------------------------------------------------------------------------
#~     # The following hash allows you to change the text colour values used for
#~     # various common interface.
#~     #--------------------------------------------------------------------------
#~     COLOURS ={
#~     # Used For   => Colour ID
#~       :normal    =>  0,  # Normal text colour.
#~       :system    => 16,  # System use. Namely vocab.
#~       :crisis    => 17,  # Low HP colour.
#~       :lowmp     => 17,  # Low MP colour.
#~       :knockout  => 18,  # Knocked out text colour.
#~       :gaugeback => 19,  # Generic gauge back.
#~       :exhaust   =>  7,  # Exhausted HP and MP bars.
#~       :hp_back   => 19,  # HP gauge back.
#~       :hp_gauge1 => 28,  # HP gradient no 1.
#~       :hp_gauge2 => 29,  # HP gradient no 2.
#~       :mp_back   => 19,  # MP gauge back.
#~       :mp_gauge1 => 22,  # MP gradient no 1.
#~       :mp_gauge2 => 23,  # MP gradient no 2.
#~       :power_up  => 24,  # Boosted stat colour.
#~       :power_dn  => 25,  # Nerfed stat colour.
#~     } # Do not remove.
    
    #--------------------------------------------------------------------------
    # - Crisis Colour Settings -
    #--------------------------------------------------------------------------
    # This determines at what percentage will HP and MP display their crisis
    # colours rather than a set 25%. Default value is 25%.
    #--------------------------------------------------------------------------
    CRISIS_HP = 25
    CRISIS_MP = 25
    
    #--------------------------------------------------------------------------
    # - Window Gauge Height -
    #--------------------------------------------------------------------------
    # This will determine the default gauge height used for HP and MP gauges.
    #--------------------------------------------------------------------------
    GAUGE_HEIGHT = 20
    
    #--------------------------------------------------------------------------
    # - Scene Skill Scroll Limit -
    #--------------------------------------------------------------------------
    # This adjusts the amount of skills needed to prevent the L and R buttons
    # from scrolling across different actors in the Skill Scene.
    #--------------------------------------------------------------------------
    SKILL_LIST_SIZE = 22
    
    #--------------------------------------------------------------------------
    # - Shown States Upgrade -
    #--------------------------------------------------------------------------
    # Enable this to show the turns remaining on a state. This will only appear
    # if a state has a turn counter and has more than an initial state release
    # probability of greater than 0%. The next values adjust the default text
    # colour used if no <turn colour n> tag is used. 
    #--------------------------------------------------------------------------
    DRAW_STATE_TURNS  = true
    STATE_TURN_COLOUR = 0
    STATE_TURN_F_SIZE = 16       # Font size used for the state.
    STATE_TURN_BOLD   = false    # Should the font be bold?
    
    #--------------------------------------------------------------------------
    # - State Resist Buffer -
    #--------------------------------------------------------------------------
    # If the success rate is under this percentage, the enemy will be
    # considered resistant against that state.
    #--------------------------------------------------------------------------
    MIN_STATE_RESIST = 10
    
    #--------------------------------------------------------------------------
    # - Animation Rate -
    #--------------------------------------------------------------------------
    # This adjusts the animation rate played by battle animations. By default,
    # animations are played at 40fps with a rate of 4. By changing it to 3, the
    # animations will change to 60fps for a smoother effect. Beware of using
    # heavy animations that may cause the player's computer to explode.
    #--------------------------------------------------------------------------
    ANIMATION_RATE = 3
    
  end # SETTING
end # Y6

#==============================================================================
# Script that changes the default font settings.
#==============================================================================

Font.default_name = Y6::SETTING::DEFAULT_FONT_NAME
Font.default_size = Y6::SETTING::DEFAULT_FONT_SIZE
Font.default_bold = Y6::SETTING::DEFAULT_FONT_BOLD
Font.default_italic = Y6::SETTING::DEFAULT_FONT_ITALIC
Font.default_shadow = Y6::SETTING::DEFAULT_FONT_SHADOW

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

#==============================================================================
# ** UserControl
#------------------------------------------------------------------------------
#  Represents basic components of a user control (mix of controls) on a window
#==============================================================================

class UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # User control activity
  attr_reader :active
  # User control visibility
  attr_reader :visible
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     active : user control activity
  #     visible : user control visibility
  #--------------------------------------------------------------------------
  def initialize(active, visible)
    @active = active
    @visible = visible
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def visible=(visible)
  end
  
  #--------------------------------------------------------------------------
  # * Set of the user control activity (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def active=(active)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
    
  #--------------------------------------------------------------------------
  # * Determine rectangles to position controls in the user control 
  #   (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def determine_rects
  end
  private :determine_rects
  
end

#==============================================================================
# ** UCLabelIconsList
#------------------------------------------------------------------------------
#  Represents a Label control with a list of Icon user controls on a window
#==============================================================================

class UCLabelIconsList < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control
  attr_reader :cLabel
  # List of Icon user controls
  attr_reader :ucIcons
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Window in which the user control will be drawn 
  @window = nil
  # Rectangle to position the Icon user controls
  @rectIcons = nil
  # Array containing the icon indexes to show in Icon user controls
  @icons = nil

  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get & Set the icons array that will be drawn
  #--------------------------------------------------------------------------
  # GET
  def icons()
    return @icons 
  end
  # SET
  def icons=(icons)
    @ucIcons = []
    if (icons != nil)
      for i in 0 .. icons.size-1
        @ucIcons[i] = UCIcon.new(@window, @rectIcons, icons[i])
        @ucIcons[i].active = @active
        @ucIcons[i].visible = @visible
      end
    end
    @icons = icons 
  end
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cLabel.visible = visible
    for i in 0 .. @ucIcons.size-1
      @ucIcons[i].visible = visible
    end
  end
  
  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabel.active = active
    for i in 0 .. @ucIcons.size-1
      @ucIcons[i].active = active
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rectLabel : rectangle to position the Label control
  #     rectIcons : rectangle to position the Icon user controls
  #     label : content in the Label control 
  #     icons : array containing the icon indexes to show in Icon user controls
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rectLabel, rectIcons, label, icons, active=true, 
                 visible=true)
    super(active, visible)
    @cLabel = CLabel.new(window, rectLabel, label)
    @cLabel.active = active
    @cLabel.visible = visible
    @window = window
    @rectIcons = rectIcons
    self.icons = icons
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the label and the icons on the window
  #-------------------------------------------------------------------------- 
  def draw()
    @cLabel.draw()
    draw_icons()
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the icons
  #-------------------------------------------------------------------------- 
  def draw_icons()
    for i in 0 .. @ucIcons.size-1
      @ucIcons[i].cIcon.rect = Rect.new(@rectIcons.x + i*24, @rectIcons.y, 24, 24)
      @ucIcons[i].draw()
    end
  end
  private :draw_icons
  
end

#==============================================================================
# ** UCControlsSwitchableList
#------------------------------------------------------------------------------
#  Represents a list of controls on a window that switch after some time when 
#  there are more controls than the space available in the rectangle 
#  that position it to show the other controls
#==============================================================================

class UCControlsSwitchableList < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # List of controls
  attr_reader :ucControls
  # Rectangle to position the controls
  attr_reader :rectControls
  # Timeout used (in milliseconds) to switch between controls
  attr_reader :timeout
  # Number of controls to show
  attr_accessor :number
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Frames counter to switch controls
  @ctrFrames = 0
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set the timeout before switching between controls
  #--------------------------------------------------------------------------
  def timeout=(timeout)
    @timeout = timeout.to_f/1000 * 60
  end
  
  #--------------------------------------------------------------------------
  # * Set the controls array that will be drawn
  #--------------------------------------------------------------------------
  # SET
  def controls=(controls)
    @ctrFrames = 0
    @ucControls = []
    if (controls != nil)
      for i in 0 .. controls.size-1
        @ucControls[i] = controls[i]
        @ucControls[i].active = @active
        @ucControls[i].visible = @visible
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    for i in 0 .. @ucControls.size-1
      @ucControls[i].visible = visible
    end
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    for i in 0 .. @ucControls.size-1
      @ucControls[i].active = active
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     rectControls : rectangle to position the controls
  #     controls : array containing the controls
  #     number : number of controls to show
  #     timeout : timeout used (in milliseconds) to switch between controls
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(rectControls, controls, number, timeout, 
                 active=true, visible=true)
    super(active, visible)
    @rectControls = rectControls
    @ctrFrames = 0
    if controls != nil
      self.controls = controls
    end
    @number = number
    self.timeout = timeout
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw a batch of controls depending on the number to show 
  #-------------------------------------------------------------------------- 
  def draw()
    draw_controls()
  end

  #--------------------------------------------------------------------------
  # * Frame Update
  #-------------------------------------------------------------------------- 
  def update()
    clear_switchable()
    draw_controls()
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////

  #--------------------------------------------------------------------------
  # * Draw controls
  #-------------------------------------------------------------------------- 
  def draw_controls()
    startControlPos = (@ctrFrames / self.timeout).to_i * self.number
    if (startControlPos >= @ucControls.size)
      @ctrFrames = 0
      startControlPos = 0
    end

    for i in startControlPos .. startControlPos + self.number-1
      if @ucControls[i] != nil
        draw_switchable(@ucControls[i], i-startControlPos)
      end
    end
    @ctrFrames +=1
  end
  private :draw_controls
  
  #--------------------------------------------------------------------------
  # * Draw the control (contents are defined by the subclasses)
  #     control : control to draw
  #     index : index to position the control
  #-------------------------------------------------------------------------- 
  def draw_switchable(control, index)
  end
  private :draw_switchable
  
  #--------------------------------------------------------------------------
  # * Clear the controls (contents are defined by the subclasses)
  #-------------------------------------------------------------------------- 
  def clear_switchable()
  end
  private :clear_switchable
  
end

#==============================================================================
# ** UCLabelIconsSwitchableList
#------------------------------------------------------------------------------
#  Represents a Label control with a list of Icon user controls on a window. The 
#  latter switch after some time when there are more icons than the space 
#  available in the rectangle that position it to show the other icons
#==============================================================================

class UCLabelIconsSwitchableList < UCControlsSwitchableList

  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control
  attr_reader :cLabel
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Window in which the user control will be drawn 
  @window = nil
  # Array containing the icon indexes to show in Icon user controls
  @icons = nil
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get & Set the icons array that will be drawn
  #--------------------------------------------------------------------------
  # GET
  def icons()
    return @icons 
  end
  # SET
  def icons=(icons)
    @ctrFrames = 0
    @ucControls = []
    if (icons != nil)
      for i in 0 .. icons.size-1
        @ucControls[i] = UCIcon.new(@window, @rectControls, icons[i])
        @ucControls[i].active = @active
        @ucControls[i].visible = @visible
      end
    end
    @icons = icons 
  end
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cLabel.visible = visible
    super
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabel.active = active
    super
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rectLabel : rectangle to position the Label control
  #     rectIcons : rectangle to position the Icon user controls
  #     label : content in the Label control 
  #     icons : array containing the icon indexes to show in Icon user controls
  #     number : number of icons to show
  #     timeout : timeout used (in milliseconds) to switch between icons
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rectLabel, rectIcons, label, icons, 
                 number, timeout, active=true, visible=true)
    super(rectIcons, nil, number, timeout, active, visible)
    @window = window
    self.icons = icons
    @cLabel = CLabel.new(window, rectLabel, label)
    @cLabel.active = active
    @cLabel.visible = visible
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the label and the icons on the window
  #-------------------------------------------------------------------------- 
  def draw()
    super
    @cLabel.draw()
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////

  #--------------------------------------------------------------------------
  # * Draw the switchable icons
  #-------------------------------------------------------------------------- 
  def draw_switchable(control, index)
    control.cIcon.rect = Rect.new(@rectControls.x + index*24,
                                  @rectControls.y, 24, 24)
    control.draw()
  end
  private :draw_switchable
  
  #--------------------------------------------------------------------------
  # * Clear the controls
  #-------------------------------------------------------------------------- 
  def clear_switchable()
    for i in 0 .. @ucControls.size-1
      if !@ucControls[i].cIcon.rect.nil?
        @ucControls[i].cIcon.bitmap.clear_rect(@ucControls[i].cIcon.rect)
      end
    end
  end
  private :clear_switchable
    
end

#==============================================================================
# ** UCLabelIconControlsSwitchableList
#------------------------------------------------------------------------------
#  Represents a list of UCLabelIcon controls on a window. The latter switch
#  after some time when there are more user controls than the space available
#  in the rectangle that position it to show the other user controls
#==============================================================================

class UCLabelIconControlsSwitchableList < UCControlsSwitchableList
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////

  #--------------------------------------------------------------------------
  # * Draw the switchable UCLabelIcon
  #-------------------------------------------------------------------------- 
  def draw_switchable(control, index)
    labelRect = control.cLabel.rect
    control.cLabel.rect = Rect.new(@rectControls.x + index*labelRect.width,
                                   labelRect.y, labelRect.width, labelRect.height)
    control.ucIcon.cIcon.rect = Rect.new(@rectControls.x + index*24,
                                         @rectControls.y, 24, 24)
    control.draw()
  end
  private :draw_switchable
  
  #--------------------------------------------------------------------------
  # * Clear the controls
  #-------------------------------------------------------------------------- 
  def clear_switchable()
    for i in 0 .. @ucControls.size-1
      if !@ucControls[i].cLabel.rect.nil?
        @ucControls[i].cLabel.bitmap.clear_rect(@ucControls[i].cLabel.rect)
      end
      if !@ucControls[i].ucIcon.cIcon.rect.nil?
        @ucControls[i].ucIcon.cIcon.bitmap.clear_rect(@ucControls[i].ucIcon.cIcon.rect)
      end
    end
  end
  private :clear_switchable
  
end

#==============================================================================
# ** UCLabelIcon
#------------------------------------------------------------------------------
#  Represents a Label with an Icon user control on a window
#==============================================================================

class UCLabelIcon < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Instance Variables
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control
  attr_reader :cLabel
  # Icon user control
  attr_reader :ucIcon
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cLabel.visible = visible
    @ucIcon.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabel.active = active
    @ucIcon.active = active
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rectLabel : rectangle to position the Label control
  #     rectIcon : rectangle to position the Icon user control
  #     label : content in the Label control 
  #     iconIndex : index of the icon to show in the Icon user control
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rectLabel, rectIcon, label, iconIndex, active=true,
                 visible=true)
    super(active, visible)
    @cLabel = CLabel.new(window, rectLabel, label)
    @cLabel.active = active
    @cLabel.visible = visible
    @ucIcon = UCIcon.new(window, rectIcon, iconIndex)
    @ucIcon.active = active
    @ucIcon.visible = visible
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the label and the icon on the window
  #--------------------------------------------------------------------------
  def draw()
    @ucIcon.draw()
    @cLabel.draw()
  end
  
end

#==============================================================================
# ** UCLabelValue
#------------------------------------------------------------------------------
#  Represents a pair of Label controls (label/value) on a window
#==============================================================================

class UCLabelValue < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control "Label"
  attr_reader   :cLabel
  # Label control "Value"
  attr_reader   :cValue
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cLabel.visible = visible
    @cValue.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabel.active = active
    @cValue.active = active
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rectLabel : rectangle to position the Label control "Label"
  #     rectValue : rectangle to position the Label control "Value"
  #     label : content in the Label control "Label"
  #     value : content in the Label control "Value"
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rectLabel, rectValue, label, value, active=true, 
                 visible=true)
    super(active, visible)
    @cLabel = CLabel.new(window, rectLabel, label)
    @cLabel.active = active
    @cLabel.visible = visible
    @cValue = CLabel.new(window, rectValue, value)
    @cValue.active = active
    @cValue.visible = visible  
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the label and the value on the window
  #--------------------------------------------------------------------------
  def draw()
    @cLabel.draw()
    @cValue.draw()
  end
  
end

#==============================================================================
# ** UCLabelIconValue
#------------------------------------------------------------------------------
#  Represents a pair of Label controls (label/value) and an Icon user control 
#  on a window
#==============================================================================

class UCLabelIconValue < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control "Label"
  attr_reader   :cLabel
  # Icon user control
  attr_reader   :ucIcon
  # Label control "Value"
  attr_reader   :cValue
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cLabel.visible = visible
    @ucIcon.visible = visible
    @cValue.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabel.active = active
    @ucIcon.active = active
    @cValue.active = active
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rectLabel : rectangle to position the Label control "Label"
  #     rectIcon : rectangle to position the Icon user control
  #     rectLabel : rectangle to position the Label control "Value"
  #     label : content in the Label control "Label"
  #     iconIndex : index of the icon to show in the Icon user control
  #     value : content in the Label control "Value"
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rectLabel, rectIcon, rectValue, label, iconIndex, value,
                 active=true, visible=true)
    super(active, visible)
    @cLabel = CLabel.new(window, rectLabel, label)
    @cLabel.active = active
    @cLabel.visible = visible
    @ucIcon = UCIcon.new(window, rectIcon, iconIndex)
    @ucIcon.active = active
    @ucIcon.visible = visible
    @cValue = CLabel.new(window, rectValue, value)
    @cValue.active = active
    @cValue.visible = visible
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the label and the icon on the window
  #--------------------------------------------------------------------------
  def draw()
    @ucIcon.draw()
    @cLabel.draw()
    @cValue.draw()
  end
  
end

#==============================================================================
# ** UCCharacterGraphic
#------------------------------------------------------------------------------
#  Represents an actor's character graphic on a window
#==============================================================================

class UCCharacterGraphic < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control to draw the character graphic
  attr_reader   :cCharGraphic
  # Character graphic direction
  #   0 - Bottom
  #   1 - Left
  #   2 - Right
  #   3 - Top
  attr_accessor :direction
  # Actor object
  attr_accessor :actor
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cCharGraphic.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cCharGraphic.active = active
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the Image control
  #     actor : actor object
  #     align : character graphic alignment
  #     opacity : character graphic opacity
  #     valign : character graphic vertical alignment
  #     direction : character graphic direction
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, actor, align=0, opacity=255, valign=0, direction=0,
                 active=true, visible=true)
    super(active, visible)
    self.actor = actor
    @direction = direction
    @cCharGraphic = CImage.new(window, rect, nil, nil, align, opacity, valign,
                               active, visible)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw character graphic on the window
  #--------------------------------------------------------------------------
  def draw()
    if self.actor != nil
      bitmap = Cache.character(self.actor.character_name)
      sign = self.actor.character_name[/^[\!\$]./]
      if sign != nil && sign.include?('$')
        cw = bitmap.width / 3
        ch = bitmap.height / 4
      else
        cw = bitmap.width / 12
        ch = bitmap.height / 8
      end
      n = self.actor.character_index
      
      @cCharGraphic.img_bitmap = bitmap
      @cCharGraphic.src_rect = Rect.new((n%4*3+1)*cw, (n/4*4+@direction)*ch, cw, ch)
      @cCharGraphic.draw()
    end
  end
  
end

#==============================================================================
# ** UCCharacterFace
#------------------------------------------------------------------------------
#  Represents an actor's character face on a window
#==============================================================================

class UCCharacterFace < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control to draw the character face
  attr_reader   :cCharFace
  # Actor object
  attr_accessor :actor
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cCharFace.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cCharFace.active = active
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the Image control
  #     actor : actor object
  #     align : character face alignment
  #     opacity : character face opacity
  #     valign : character face vertical alignment
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, actor, align=0, opacity=255, valign=0, 
                 active=true, visible=true)
    super(active, visible)
    self.actor = actor
    @cCharFace = CImage.new(window, rect, nil, nil, align, opacity, valign,
                            active, visible)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw character face on the window
  #--------------------------------------------------------------------------
  def draw()
    draw((96 - @cCharFace.rect.width) / 2, (96 - @cCharFace.rect.height) / 2)
  end
  
  #--------------------------------------------------------------------------
  # * Draw character face on the window
  #     x_adjustment : Custom adjustment to the X coordinate
  #     y_adjustment : Custom adjustment to the Y coordinate
  #--------------------------------------------------------------------------
  def draw(x_adjustment=0,y_adjustment=0)
    if self.actor != nil
      bitmap = Cache.face(self.actor.face_name)
      x = actor.face_index % 4 * 96 + x_adjustment
      y = actor.face_index / 4 * 96 + y_adjustment
        
      @cCharFace.img_bitmap = bitmap
      @cCharFace.src_rect = Rect.new(x, y, 96, 96)
      @cCharFace.draw()
    end
  end
  
end

#==============================================================================
# ** UCEnemyGraphic
#------------------------------------------------------------------------------
#  Represents an enemy graphic on a window
#==============================================================================

class UCEnemyGraphic < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control to draw the enemy graphic
  attr_reader   :cEnemyGraphic
  # Enemy object
  attr_accessor :enemy
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cEnemyGraphic.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cEnemyGraphic.active = active
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the Image control
  #     enemy : enemy object
  #     align : enemy graphic alignment
  #     opacity : enemy graphic opacity
  #     valign : enemy graphic vertical alignment
  #     resize_mode : resize mode (see CResizableImage)
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, enemy, align=0, opacity=255, valign=0, resize_mode=nil, 
                 active=true, visible=true)
    super(active, visible)
    self.enemy = enemy
    @cEnemyGraphic = CResizableImage.new(window, rect, 
                     nil, nil, align, opacity, valign, resize_mode, 
                     active, visible)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw enemy graphic on the window
  #--------------------------------------------------------------------------
  def draw()
    if self.enemy != nil
      bitmap = Cache.battler(self.enemy.battler_name, self.enemy.battler_hue)
      @cEnemyGraphic.img_bitmap = bitmap
      @cEnemyGraphic.src_rect = Rect.new(0, 0, bitmap.width, bitmap.height)
      @cEnemyGraphic.draw()
    end
  end
  
end

#==============================================================================
# ** UCBackgroundImage
#------------------------------------------------------------------------------
#  Represents an Image as the background of a window
#==============================================================================

class UCBackgroundImage < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control
  attr_reader :cImage
  # Name of the image in Cache.picture
  attr_accessor :image
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cImage.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cImage.active = active
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     image : name of the image in Cache.picture
  #     align : background image alignment
  #     opacity : background image opacity
  #     valign : background image vertical alignment
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, image, align=0, opacity=255, valign=0, active=true, visible=true)
    super(active, visible)
    self.image = image
    @cImage = CImage.new(window, Rect.new(0, 0, window.width, window.height), 
                         nil, nil, align, opacity, valign, active, visible)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the background image on the window
  #--------------------------------------------------------------------------
  def draw()
    if self.image != nil
      bitmap = Cache.picture(self.image)
      @cImage.img_bitmap = bitmap
      @cImage.src_rect = Rect.new(0, 0, bitmap.width, bitmap.height)
      @cImage.draw()
    end
  end
  
end

#==============================================================================
# ** UCIcon
#------------------------------------------------------------------------------
#  Represents an Icon user control on a window
#==============================================================================

class UCIcon < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control to draw the icon
  attr_reader :cIcon
  # Icon index
  attr_accessor :iconIndex
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cIcon.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cIcon.active = active
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the Image control
  #     iconIndex : index of the Icon to draw
  #     align : icon image alignment
  #     opacity : icon image opacity
  #     valign : icon image vertical alignment
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, iconIndex, align=0, opacity=255, valign=0, 
                 active=true, visible=true)
    super(active, visible)
    self.iconIndex = iconIndex
    @cIcon = CImage.new(window, rect, nil, nil, align, opacity, valign, 
                        active, visible)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the icon on the window
  #--------------------------------------------------------------------------
  def draw()
    if self.iconIndex != nil
      bitmap = Cache.system("IconSet")
      @cIcon.img_bitmap = bitmap
      @cIcon.src_rect = Rect.new(self.iconIndex % 16 * 24, self.iconIndex / 16 * 24, 
                        24, 24)
      @cIcon.draw()
    end
  end
  
end

#==============================================================================
# ** UCNumericUpDown
#------------------------------------------------------------------------------
#  Represents a NumericUpDown user control on a window
#==============================================================================

class UCNumericUpDown < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control to show the value
  attr_reader   :cLabelNumber
  # Value of the user control
  attr_reader   :value
  # Pattern used to format the value
  attr_accessor :pattern
  # Minimum value of the user control
  attr_accessor :min
  # Maximum value of the user control
  attr_accessor :max
  # Step used for the operations Up/Down of the user control
  attr_accessor :step
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cLabelNumber.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cLabelNumber.active = active
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the user control
  #     value : value of the user control
  #     pattern : pattern to use to format the value
  #     min : minimum value of the user control
  #     max : maximum value of the user control
  #     step : step used for the operations Up/Down of the user control
  #     align : text alignment
  #     font : font of the value
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, value, pattern=nil, min=0, max=99, step=1, align=0, 
                 font=nil, active=true, visible=true)
    super(active, visible)
    @cLabelNumber = CLabel.new(window, rect, nil, align, font)
    @cLabelNumber.active = active
    @cLabelNumber.visible = visible
    @value = value
    self.pattern = pattern
    self.min = min
    self.max = max
    self.step = step
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the NumericUpDown on the window
  #--------------------------------------------------------------------------
  def draw()
    if (self.pattern != nil)
      @cLabelNumber.text = sprintf(self.pattern, @value.to_s)
    else
      @cLabelNumber.text = @value.to_s
    end
    @cLabelNumber.draw()
  end
  
  #--------------------------------------------------------------------------
  # * Up operation of the NumericUpDown
  #--------------------------------------------------------------------------
  def up()
    if @value < self.max
      @value = [@value + self.step, self.max].min
    end
    #@cLabelNumber.text = sprintf(@pattern, @value.to_s)
  end
  
  #--------------------------------------------------------------------------
  # * Down operation of the NumericUpDown
  #--------------------------------------------------------------------------
  def down()
    if @value > self.min
      @value = [@value - self.step, self.min].max
    end
    #@cLabelNumber.text = sprintf(@pattern, @value.to_s)
  end
  
  #--------------------------------------------------------------------------
  # * Reset operation of the NumericUpDown
  #--------------------------------------------------------------------------
  def reset()
    @value = self.min
  end
  
end

#==============================================================================
# ** UCBar
#------------------------------------------------------------------------------
#  Represents a Bar user control on a window
#==============================================================================

class UCBar < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Rectangle control to position the Bar user control
  attr_reader   :cRectangle
  # Rectangle control that fill the Bar user control
  attr_reader   :cFillRectangle
  # Rectangle control that forms the border of the Bar user control
  attr_reader   :cBorder
  # Current value (to fill the rectangle)
  attr_accessor :value
  # Maximum value (to have a filled rectangle)
  attr_accessor :max_value
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cRectangle.visible = visible
    @cFillRectangle.visible = visible
    if !@cBorder.nil?
      @cBorder.visible = visible
    end
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cRectangle.active = active
    @cFillRectangle.active = active
    if !@cBorder.nil?
      @cBorder.active = active
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the user control
  #     color1 : fill color 1 of the user control
  #     color2 : fill color 2 of the user control (used for gradient) 
  #     back_color : back color of the user control
  #     value : current value (to fill the rectangle)
  #     max_value : maximum value (to reach to have a filled rectangle)
  #     border : size of the border
  #     border_color : border color
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, color1, color2, back_color, value, max_value,
                 border=0, border_color=nil, active=true, visible=true)
    super(active, visible)
    self.value = value
    self.max_value = max_value
    
    if border > 0 && !border_color.nil?
      border_rect = Rect.new(rect.x, rect.y, rect.width, rect.height)
      @cBorder = CRectangle.new(window, border_rect, border_color)
      rect = Rect.new(rect.x + border, rect.y + border, rect.width - border*2, rect.height - border*2)
    end
    
    @cRectangle = CRectangle.new(window, rect, back_color)
    gradient_rect = Rect.new(rect.x, rect.y, rect.width, rect.height)
    @cFillRectangle = CRectangle.new(window, gradient_rect, color1, color2)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the bar on the window
  #--------------------------------------------------------------------------
  def draw()
    if !@cBorder.nil?
      @cBorder.draw()
    end
    @cRectangle.draw()
    
    value = self.value
    if (value == nil)
      value = 0
    end
    max = self.max_value
    if (max == nil)
      max = value
    end
    if (max == 0)
      max = 1
    end
    gw = @cRectangle.rect.width * value / max
    
    @cFillRectangle.rect.width = gw
    @cFillRectangle.draw()
  end
  
end

#==============================================================================
# ** UCGraph
#------------------------------------------------------------------------------
#  Represents a Graph user control on a window
#==============================================================================

class UCGraph < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Polygon control for the background of the graph
  attr_reader   :cBackground
  # Polygon control for the borders of the graph
  attr_reader   :cBorders
  # Coordinates (X,Y) of the center of the graph
  attr_accessor :ox, :oy
  # Radius of the graph
  attr_accessor :radius
  # GraphElement objects list (see GraphElement)
  attr_accessor :elements
  # Pattern used to format the value
  attr_accessor :pattern
  # Maximum value (to have a positive filled branch)
  attr_accessor :max_value
  # Minimum value (to have a negative filled branch)
  attr_accessor :min_value
  # Font for the values of the graph
  attr_accessor :font
  # Positive fill color 1 of the user control 
  attr_reader   :pos_color1
  # Positive fill color 2 of the user control (used for gradient) 
  attr_reader   :pos_color2
  # Negative fill color 1 of the user control 
  attr_reader   :neg_color1
  # Negative fill color 2 of the user control (used for gradient) 
  attr_reader   :neg_color2
  # True to hide the values of the graph, else false
  attr_accessor :hide_values
  # Padding (in pixels) added to the positions of the values
  attr_accessor :padding
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Triangle controls list to draw each branch of the graph
  @cTriangles = nil
  # LabelIcon user controls list to draw the values of each branch of the graph
  @ucLabelIcons = nil
  # Window in which the user control will be drawn 
  @window = nil
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cBackground.visible = visible if @cBackground != nil
    @cBorders.visible = visible if @cBorders != nil
    if @cTriangles != nil
      for triangle in @cTriangles
        triangle.visible = visible
      end
    end
    if @ucLabelIcons != nil
      for lblIcon in @ucLabelIcons
        lblIcon.visible = visible
      end
    end
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cBackground.active = active if @cBackground != nil
    @cBorders.active = active if @cBorders != nil
    if @cTriangles != nil
      for triangle in @cTriangles
        triangle.active = active
      end
    end
    if @ucLabelIcons != nil
      for lblIcon in @ucLabelIcons
        lblIcon.active = active
      end
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     ox : x value of the coordinate of the center of the graph
  #     oy : y value of the coordinate of the center of the graph
  #     radius : radius of the graph
  #     elements : GraphElement objects list (see GraphElement)
  #     pattern : pattern used to format the value
  #     max_value : maximum value (to have a positive filled branch)
  #     min_value : minimum value (to have a negative filled branch)
  #     font : font for the values of the graph
  #     pos_color1 : positive fill color 1 of the user control
  #     pos_color2 : positive fill color 2 of the user control (used for gradient) 
  #     neg_color1 : negative fill color 1 of the user control
  #     neg_color2 : negative fill color 2 of the user control (used for gradient) 
  #     back_color : background color
  #     border : size of the border
  #     br_color1 : border color 1
  #     br_color2 : border color 2 (used for gradient) 
  #     hide_values : true to hide the values of the graph, else false
  #     padding : padding (in pixels) added to the positions of the values
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, ox, oy, radius, elements, pattern, max_value, min_value,
                 font, pos_color1, pos_color2, neg_color1, neg_color2, 
                 back_color=nil, border=0, br_color1=nil, br_color2=br_color1,
                 hide_values=false, padding=15, active=true, visible=true)
    super(active, visible)
    @window = window
    self.ox = ox
    self.oy = oy
    self.radius = radius - padding
    self.elements = elements
    self.pattern = pattern
    self.max_value = max_value
    self.min_value = min_value
    self.hide_values = hide_values
    self.padding = padding
    self.font = font
    
    if !back_color.nil?
      @cBackground = CPolygon.new(window, nil, back_color, true)
      @cBackground.active = active
      @cBackground.visible = visible
    end
    
    if border > 0 && !br_color1.nil?
      @cBorders = CPolygon.new(window, nil, nil, false, nil,
                               border, br_color1, br_color2)
      @cBorders.active = active
      @cBorders.visible = visible
    end
  
    @pos_color1 = pos_color1
    @pos_color2 = pos_color2
    @neg_color1 = neg_color1
    @neg_color2 = neg_color2
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the graph on the window
  #--------------------------------------------------------------------------
  def draw()
    # Return if number of elements is less than or 3
    return if self.elements == nil
    return if self.elements.size <= 3
    
    # Find the angle in radians to split the points
    angle = 2 * Math::PI / self.elements.size

    # Determine the graph vertices
    local_vertices = []
    for i in 0..self.elements.size-1
      x = Integer(self.radius * Math.cos(angle*i))
      y = Integer(self.radius * Math.sin(angle*i))
      local_vertices.push([x,y])
    end

    # Create the drawing elements
    drawingElements = []
    percentage = 0
    color1 = nil
    color2 = nil
    
    for i in 0..local_vertices.size-1
      elem = self.elements[i]

      max = self.max_value
      if (max == nil)
        max = elem.value
      end
      if (max == 0)
        max = 1
      end
      
      min = self.min_value
      if (min == nil)
        min = elem.value
      end
      if (min == 0)
        min = 1
      end
      
      # Switch colors when negative value
      if elem.value >= 0
        color1 = @pos_color1
        color2 = @pos_color2
        percentage = (elem.value / max.to_f).abs
      else
        color1 = @neg_color1
        color2 = @neg_color2
        percentage = (elem.value / min.to_f).abs
      end

      x2 = Integer(local_vertices[i-1][0] * percentage)
      y2 = Integer(local_vertices[i-1][1] * percentage)
      x3 = Integer(local_vertices[i][0] * percentage)
      y3 = Integer(local_vertices[i][1] * percentage)
      
      # Create a triangle for an element
      triangle = CTriangle.new(@window, 0, 0, x2, y2, x3, y3, color1, true, color2)
      triangle.active = active
      triangle.visible = visible
      
      # Determine labels position     
      i -= 1
      x = Integer((self.radius + self.padding) * Math.cos(angle*i + angle/2))
      y = Integer((self.radius + self.padding)* Math.sin(angle*i + angle/2))
      
      # Add every information for an element
      drawingElements.push([elem, triangle, [x, y]])
    end
    
    # Draw background of the graph
    if !@cBackground.nil?
      @cBackground.vertices = copy_vertices(local_vertices)
      @cBackground.translate(ox,oy)
      @cBackground.draw()
    end
    
    # Draw each elements of the graph 
    @cTriangles = []
    @ucLabelIcons = []
    
    for dElem in drawingElements
      element = dElem[0]
      triangle = dElem[1]
      x = dElem[2][0] + ox
      y = dElem[2][1] + oy
      
      # Update labels position
      x-=12
      y-=12
      # Left side
      if x < ox
        x_label = x - 48
        label_align = 2
      else
        x_label = x + 24
        label_align = 0
      end
      
      if self.hide_values
        lblIcon = UCIcon.new(@window, Rect.new(x,y,24,24), element.iconIndex)
        lblIcon.active = active
        lblIcon.visible = visible
      else
        lblIcon = UCLabelIcon.new(@window, Rect.new(x_label,y,48,24), Rect.new(x,y,24,24), 
                                  nil, element.iconIndex,
                                  active, visible)
        if (self.pattern != nil)
          lblIcon.cLabel.text = sprintf(self.pattern, element.value.to_s)
        else
          lblIcon.cLabel.text = element.value.to_s
        end
        lblIcon.cLabel.font = self.font
        lblIcon.cLabel.align = label_align
      end
      triangle.translate(ox,oy)
      
      @cTriangles.push(triangle)
      @ucLabelIcons.push(lblIcon)
      
      lblIcon.draw()
      triangle.draw()
    end
    
    # Draw borders of the graph
    if !@cBorders.nil?
      @cBorders.vertices = copy_vertices(local_vertices)
      @cBorders.translate(ox,oy)
      @cBorders.draw()
    end
    
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Deep copy the vertices
  #     vertices : vertices to copy
  #--------------------------------------------------------------------------
  def copy_vertices(vertices)
    deep_copy = []
    
    for i in 0..vertices.size-1
      x = vertices[i][0]
      y = vertices[i][1]
      deep_copy.push([x,y])
    end
    
    return deep_copy
  end
  private:copy_vertices
  
end

#==============================================================================
# ** UCImageBorder
#------------------------------------------------------------------------------
#  Represents an Image control with a border on a window
#==============================================================================

class UCImageBorder < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control
  attr_reader   :cImage
  # Rectangle controls that forms the border of the Image control
  attr_reader   :cBorders
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cImage.visible = visible
    @cBorders.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cImage.active = active
    @cBorders.active = active
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     rect : rectangle to position the control
  #     bitmap : bitmap object containing the image to show
  #     src_rect : rectangle of the image to get in the bitmap
  #     align : image alignment
  #     opacity : image opacity
  #     valign : image vertical alignment
  #     border : size of the border
  #     border_color : border color
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, bitmap, src_rect, align=0, opacity=255, 
                 valign=0, border=0, border_color=nil,
                 active=true, visible=true)
    super(active, visible)
    
    if border > 0 && !border_color.nil?
      vertices = [[rect.x, rect.y],[rect.x+rect.width, rect.y],
                  [rect.x+rect.width, rect.y+rect.height],
                  [rect.x, rect.y+rect.height]]
      @cBorders = CPolygon.new(window, vertices, nil, false, nil,
                               border, border_color)
      rect = Rect.new(rect.x + border, rect.y + border, 
                      rect.width - border*2, rect.height - border*2)
    end
    
    @cImage = CImage.new(window, rect, bitmap, src_rect, align, opacity, valign)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the image and border on the window
  #--------------------------------------------------------------------------
  def draw()
    if !@cBorders.nil?
      @cBorders.draw()
    end
    @cImage.draw()
  end
  
end

#==============================================================================
# ** Control
#------------------------------------------------------------------------------
#  Represents basic components of a control on a window
#==============================================================================

class Control
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Window in which the control will be drawn
  attr_reader   :window
  # Sprite in which the control will be drawn
  attr_reader   :sprite
  # Control activity
  attr_accessor :active
  # Control visibility
  attr_accessor :visible
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get bitmap in which the control will be drawn
  #--------------------------------------------------------------------------
  # GET
  def bitmap
    # Refresh bitmap from the window since the window can decide to dispose it
    # (ex.: Window_Selectable when drawing the items)
    if @bitmap.disposed? && @window != nil
      @bitmap = @window.contents
    end
    return @bitmap
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, active, visible)
    if window.is_a?(Bitmap)
      @bitmap = window
    elsif window.is_a?(Sprite)
      @sprite = window
      @bitmap = window.bitmap
    else
      @window = window
      @bitmap = window.contents
    end
    @active = active
    @visible = visible
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update bitmap size
  #     width : new width
  #     height : new height
  #--------------------------------------------------------------------------
  def update_bitmap_size(width, height)
    @bitmap = Bitmap.update_bitmap_size(@bitmap, width, height)
    if @window != nil
      @window.contents = @bitmap
    elsif @sprite != nil
      @sprite.bitmap = @bitmap
    end
  end
  
end

#==============================================================================
# ** CDrawingObject
#------------------------------------------------------------------------------
#  Represents basic components for a drawing object on a window
#==============================================================================

class CDrawingObject < Control

  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Fill color 1 of the object
  attr_accessor :color1
  # Fill color 2 of the object (used for gradient) 
  attr_accessor :color2
  # Size of the border
  attr_accessor :border
  # Border color 1 of the object
  attr_accessor :br_color1
  # Border color 2 of the object (used for gradient) 
  attr_accessor :br_color2
  # True to draw a filled object, else false
  attr_accessor :filled
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the object will be drawn
  #     color1 : fill color 1 of the object
  #     filled : true to draw a filled object, else false
  #     color2 : fill color 2 of the object (used for gradient) 
  #     border : size of the border
  #     br_color1 : border color 1 of the object
  #     br_color2 : border color 2 of the object (used for gradient) 
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, color1, filled=true, color2=color1, 
                 border=0, br_color1=color1, br_color2=color1,
                 active=true, visible=true)
    super(window, active, visible)
    self.color1 = color1
    self.color2 = color2
    self.filled = filled
    self.border = border
    self.br_color1 = br_color1
    self.br_color2 = br_color2
  end
  
end

#==============================================================================
# ** CLabel
#------------------------------------------------------------------------------
#  Represents a Label control on a window
#==============================================================================

class CLabel < Control
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Rectangle to position the control
  attr_accessor :rect
  # Text to draw in the label
  attr_accessor :text
  # Text alignment (see Window_Base Addon)
  attr_accessor :align
  # Text font
  attr_accessor :font
  # True to draw the text in multiline, else false
  attr_accessor :multiline
  # Multiline mode (see Window_Base Addon)
  attr_accessor :multiline_mode
  # True to automatically resize bitmap to fits text contents, else false
  attr_accessor :multiline_resize
  # True to cut the text if it is too long, else false
  attr_accessor :cut_overflow
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     rect : rectangle to position the control
  #     text : text to draw in the label
  #     align : text alignment
  #     font : text font
  #     multiline : true to draw the text in multiline, else false
  #     cut_overflow : true to cut the text if it is too long, else false
  #     multiline_mode : multiline mode (see Window_Base Addon)
  #     multiline_resize : true to automatically resize bitmap to fits text contents, else false
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, text, align=0, font=nil, multiline=false, 
                 cut_overflow=false, multiline_mode=0, multiline_resize=false,
                 active=true, visible=true)
    super(window, active, visible)
    self.rect = rect
    self.text = text
    self.align = align
    if font.nil?
      self.font = Font.normal_font()
    else
      self.font = font
    end
    self.multiline = multiline
    self.multiline_mode = multiline_mode
    self.cut_overflow = cut_overflow
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible
      bitmap.font = self.font

      if !active
        bitmap.font.color.alpha = Font.inactive_alpha()
      end
      
      if self.multiline
        if self.multiline_resize
          lines = bitmap.split_multiline(self.rect, self.text, 3)
      
          if (self.rect.height * lines.size) > bitmap.height
            update_bitmap_size(self.rect.width, (self.rect.height * lines.size))
          end
        end
        bitmap.draw_multiline_text(self.rect, self.text, self.align, self.multiline_mode)
      elsif self.cut_overflow
        bitmap.draw_cut_overflow_text(self.rect, self.text, self.align)
      else
        bitmap.draw_text(self.rect, self.text, self.align)
      end
    end
  end
  
end

#==============================================================================
# ** CImage
#------------------------------------------------------------------------------
#  Represents an Image control on a window
#==============================================================================

class CImage < Control
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Rectangle to position the control
  attr_accessor :rect
  # Bitmap object containing the image to show
  attr_accessor :img_bitmap
  # Rectangle of the image to get in the bitmap
  attr_accessor :src_rect
  # Image alignment
  #   0 - Left
  #   1 - Middle
  #   2 - Right
  attr_accessor :align
  # Image opacity
  attr_accessor :opacity
  # Image vertical alignment
  #   0 - Top
  #   1 - Middle
  #   2 - Bottom
  attr_accessor :valign

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     rect : rectangle to position the control
  #     img_bitmap : bitmap object containing the image to show
  #     src_rect : rectangle of the image to get in the bitmap
  #     align : image alignment
  #     opacity : image opacity
  #     valign : image vertical alignment
  #     mirror : true to flip the image horizontally, else false
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, img_bitmap, src_rect, align=0, opacity=255, 
                 valign=0, active=true, visible=true)
    super(window, active, visible)
    self.rect = rect
    self.img_bitmap = img_bitmap
    self.src_rect = src_rect
    self.align = align
    self.opacity = opacity
    self.valign = valign
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible
      
      case self.align 
      when 0 # Left
        x = self.rect.x
      when 1 # Middle
        x = self.rect.x + self.rect.width/2 - self.src_rect.width/2
      when 2 # Right
        x = self.rect.x + self.rect.width - self.src_rect.width
      else
        x = 0
      end
      
      case self.valign 
      when 0 # Top
        y = self.rect.y
      when 1 # Middle
        y = self.rect.y + self.rect.height/2 - self.src_rect.height/2
      when 2 # Bottom
        y = self.rect.y + self.rect.height - self.src_rect.height
      else
        y = 0
      end

      if !active
        opacity = Font.inactive_alpha()
      else
        opacity = self.opacity
      end
      
      bitmap.blt(x, y, self.img_bitmap, self.src_rect, opacity)
    end
  end
  
end

#==============================================================================
# ** CResizableImage
#------------------------------------------------------------------------------
#  Represents a ResizableImage control on a window
#==============================================================================

class CResizableImage < CImage
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Resize mode
  #   0 - Full resize to fit in rectangle size (can't be aligned since will fit the rectangle)
  #   1 - Width only to fit in rectangle size
  #   2 - Height only to fit in rectangle size
  #   3 - Full resize to fit in rectangle size by respecting image ratio
  attr_accessor :resize_mode
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     rect : rectangle to position the control
  #     img_bitmap : bitmap object containing the image to show
  #     src_rect : rectangle of the image to get in the bitmap
  #     align : image alignment
  #     opacity : image opacity
  #     valign : image vertical alignment
  #     resize_mode : resize mode (see Attributes section)
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, img_bitmap, src_rect, align=0, opacity=255, 
                 valign=0, resize_mode=0, active=true, visible=true)
    super(window, rect, img_bitmap, src_rect, align, opacity, 
          valign, active, visible)
    self.resize_mode = resize_mode
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible
      temp_rect = Rect.new(self.src_rect.x, self.src_rect.y, 
                           self.src_rect.width, self.src_rect.height)
      
      case self.resize_mode
      when 0 #Full resize to fit in rectangle size
#~         bw = self.img_bitmap.width
#~         bh = self.img_bitmap.height
#~         if bw > self.rect.width
#~           bw = self.rect.width
#~            bh *= self.rect.width / self.img_bitmap.width.to_f
#~         end
#~         if bh > self.rect.height
#~           bh = self.rect.height
#~           bw *= self.rect.height / self.img_bitmap.height.to_f
#~         end
        temp_rect.width = self.rect.width
        temp_rect.height = self.rect.height
      when 1 #Width only to fit in rectangle size
#~         bw = self.img_bitmap.width
#~         if bw > self.rect.width
#~           bw = self.rect.width
#~         end
        temp_rect.width = self.rect.width
      when 2 #Height only to fit in rectangle size
#~         bh = self.img_bitmap.height
#~         if bh > self.rect.height
#~           bh = self.rect.height
#~         end
        temp_rect.height = self.rect.height
      when 3 #Full resize to fit in rectangle size by respecting image ratio
        bw = self.img_bitmap.width
        bh = self.img_bitmap.height
        if (self.rect.height / self.img_bitmap.height.to_f) > 
           (self.rect.width / self.img_bitmap.width.to_f)
          ratio = self.rect.width / self.img_bitmap.width.to_f
        else
          ratio = self.rect.height / self.img_bitmap.height.to_f
        end
        bw *= ratio
        bh *= ratio
        temp_rect.width = bw.floor
        temp_rect.height = bh.floor
      end
      
      case self.align 
      when 0 #Left
        x = self.rect.x
      when 1 #Middle
        x = self.rect.x + self.rect.width/2 - temp_rect.width/2
      when 2 #Right
        x = self.rect.x + self.rect.width - temp_rect.width
      else
        x = 0
      end

      case self.valign 
      when 0 #Top
        y = self.rect.y
      when 1 #Middle
        y = self.rect.y + self.rect.height/2 - temp_rect.height/2
      when 2 #Bottom
        y = self.rect.y + self.rect.height - temp_rect.height
      else
        y = 0
      end

      if !active
        opacity = Font.inactive_alpha()
      else
        opacity = self.opacity
      end
      
      bitmap.stretch_blt(Rect.new(x, y, temp_rect.width, temp_rect.height), 
                                  self.img_bitmap, self.src_rect, 
                                  opacity)
    end
  end
  
end

#==============================================================================
# ** CRectangle
#------------------------------------------------------------------------------
#  Represents a Rectangle control on a window
#==============================================================================

class CRectangle < Control
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Rectangle to position the control
  attr_accessor :rect
  # Fill color 1 of the control
  attr_accessor :color1
  # Fill color 2 of the control (used for gradient) 
  attr_accessor :color2
  # True to have a vertical gradient, else false
  attr_accessor :vertical
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     rect : rectangle to position the control
  #     color1 : fill color 1 of the control
  #     color2 : fill color 2 of the control (used for gradient) 
  #     vertical : true to have a vertical gradient, else false
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, color1, color2=color1, vertical=false, 
                 active=true, visible=true)
    super(window, active, visible)
    self.rect = rect
    self.color1 = color1
    self.color2 = color2
    self.vertical = vertical
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible     
      c1 = self.color1
      c2 = self.color2
      gradient = c1 != c2
      if !active
        if gradient
          c1 = Color.inactive_gauge_color1
          c2 = Color.inactive_gauge_color2
        else
          c1 = c2 = Color.gauge_back_color
        end
      end
      
      if gradient
        bitmap.gradient_fill_rect(rect.x, rect.y, rect.width, 
                                           rect.height, c1, c2, self.vertical)
      else
        bitmap.fill_rect(rect.x, rect.y, rect.width, rect.height, c1)
      end
    end
  end
  
end

#==============================================================================
# ** CPolygon
#------------------------------------------------------------------------------
#  Represents a Polygon control on a window
#==============================================================================

class CPolygon < CDrawingObject

  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Vertices to draw the polygon
  attr_accessor :vertices
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the polygon will be drawn
  #     vertices : vertices to draw the polygon
  #     color1 : fill color 1 of the polygon
  #     filled : true to draw a filled polygon, else false
  #     color2 : fill color 2 of the polygon (used for gradient) 
  #     border : size of the border
  #     br_color1 : border color 1 of the polygon
  #     br_color2 : border color 2 of the polygon (used for gradient) 
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, vertices, color1, filled=true, color2=color1, 
                 border=0, br_color1=color1, br_color2=br_color1,
                 active=true, visible=true)
    super(window, color1, filled, color2, 
          border, br_color1, br_color2, 
          active, visible)
    self.vertices = vertices
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible     
      c1 = self.color1
      c2 = self.color2
      br_c1 = self.br_color1
      br_c2 = self.br_color2
      gradient = (c1 != c2)
      br_gradient = (br_c1 != br_c2)
      if !active
        if gradient
          c1 = Color.inactive_gauge_color1
          c2 = Color.inactive_gauge_color2
        else
          c1 = c2 = Color.gauge_back_color
        end
        
        if br_gradient
          br_c1 = Color.inactive_gauge_color1
          br_c2 = Color.inactive_gauge_color2
        else
          br_c1 = br_c2 = Color.normal_color
        end
      end

      if filled
        bitmap.draw_filled_polygon(self.vertices, c1, c2)
      end

      if border > 0
        bitmap.draw_polygon(self.vertices, br_c1, self.border, br_c2)
      end

    end

  end
  
  #--------------------------------------------------------------------------
  # * Translate the polygon on the window
  #     x : x value to translate the vertices
  #     y : y value to translate the vertices
  #--------------------------------------------------------------------------
  def translate(x, y)
    for v in self.vertices
      #x component
      v[0] += x
      #y component
      v[1] += y
    end
  end
  
end

#==============================================================================
# ** CTriangle
#------------------------------------------------------------------------------
#  Represents a Triangle control on a window
#==============================================================================

class CTriangle < CDrawingObject

  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # First coordinates (X,Y) of the triangle
  attr_accessor :x1, :y1
  # Second coordinates (X,Y) of the triangle
  attr_accessor :x2, :y2
  # Third coordinates (X,Y) of the triangle
  attr_accessor :x3, :y3
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the triangle will be drawn
  #     x1 : first triangle X coordinate
  #     y1 : first triangle Y coordinate
  #     x2 : second triangle X coordinate
  #     y2 : second triangle Y coordinate
  #     x3 : third triangle X coordinate
  #     y3 : third triangle Y coordinate
  #     color1 : fill color 1 of the triangle
  #     filled : true to draw a filled triangle, else false
  #     color2 : fill color 2 of the triangle (used for gradient) 
  #     border : size of the border
  #     br_color1 : border color 1 of the triangle
  #     br_color2 : border color 2 of the triangle (used for gradient) 
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, x1, y1, x2, y2, x3, y3, color1, filled=true, 
                 color2=color1, border=0, br_color1=color1, br_color2=br_color1,
                 active=true, visible=true)
    super(window, color1, filled, color2, 
          border, br_color1, br_color2, 
          active, visible)
    self.x1 = x1
    self.y1 = y1
    self.x2 = x2
    self.y2 = y2
    self.x3 = x3
    self.y3 = y3
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible     
      c1 = self.color1
      c2 = self.color2
      br_c1 = self.br_color1
      br_c2 = self.br_color2
      gradient = (c1 != c2)
      br_gradient = (br_c1 != br_c2)
      if !active
        if gradient
          c1 = Color.inactive_gauge_color1
          c2 = Color.inactive_gauge_color2
        else
          c1 = c2 = Color.gauge_back_color
        end
        
        if br_gradient
          br_c1 = Color.inactive_gauge_color1
          br_c2 = Color.inactive_gauge_color2
        else
          br_c1 = br_c2 = Color.normal_color
        end
      end
      
      vertices = [[self.x1,self.y1], [self.x2,self.y2], [self.x3,self.y3]]
      
      if filled
        bitmap.draw_filled_polygon(vertices, c1, c2)
      end
      
      if border > 0
        bitmap.draw_polygon(vertices, br_c1, self.border, br_c2)
      end
    end
  end

  #--------------------------------------------------------------------------
  # * Translate the triangle on the window
  #     x : x value to translate the coordinates
  #     y : y value to translate the coordinates
  #--------------------------------------------------------------------------
  def translate(x, y)
    self.x1 += x
    self.y1 += y
    self.x2 += x 
    self.y2 += y
    self.x3 += x 
    self.y3 += y 
  end
  
end

#==============================================================================
# ** CCircle
#------------------------------------------------------------------------------
#  Represents a Circle control on a window
#==============================================================================

class CCircle < CDrawingObject
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Coordinates (X,Y) of the center of the circle
  attr_accessor :x, :y
  # Radius of the circle
  attr_accessor :radius
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the circle will be drawn
  #     x : center of the circle X coordinate
  #     y : center of the circle Y coordinate
  #     radius : radius of the circle
  #     color1 : fill color 1 of the circle
  #     filled : true to draw a filled circle, else false
  #     color2 : fill color 2 of the circle (used for gradient) 
  #     border : size of the border
  #     br_color1 : border color 1 of the circle
  #     br_color2 : border color 2 of the circle (used for gradient) 
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, x, y, radius, color1, filled=true, color2=color1, 
                 border=0, br_color1=color1, br_color2=br_color1,
                 active=true, visible=true)
    super(window, color1, filled, color2, 
          border, br_color1, br_color2, 
          active, visible)
    self.x = x
    self.y = y
    self.radius = radius
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible     
      c1 = self.color1
      c2 = self.color2
      br_c1 = self.br_color1
      br_c2 = self.br_color2
      gradient = (c1 != c2)
      br_gradient = (br_c1 != br_c2)
      if !active
        if gradient
          c1 = Color.inactive_gauge_color1
          c2 = Color.inactive_gauge_color2
        else
          c1 = c2 = Color.gauge_back_color
        end
        
        if br_gradient
          br_c1 = Color.inactive_gauge_color1
          br_c2 = Color.inactive_gauge_color2
        else
          br_c1 = br_c2 = Color.normal_color
        end
      end
      
      if filled
        bitmap.draw_filled_circle(self.x, self.y, self.radius, c1, c2)
      end
      
      if border > 0
        bitmap.draw_circle(self.x, self.y, self.radius, br_c1, self.border, br_c2)
      end
      
    end
  end
  
end

#==============================================================================
# ** CLine
#------------------------------------------------------------------------------
#  Represents a Line control on a window
#==============================================================================

class CLine < Control
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # First coordinates (X,Y) of the line
  attr_accessor :x1, :y1
  # Second coordinates (X,Y) of the line
  attr_accessor :x2, :y2
  # Fill color 1 of the object
  attr_accessor :color1
  # Line width
  attr_accessor :width
  # Fill color 2 of the object (used for gradient) 
  attr_accessor :color2
  # True to have a vertical gradient, else false
  attr_accessor :vertical
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the line will be drawn
  #     rect : rectangle to position the line
  #     x1 : first line X coordinate
  #     y1 : first line Y coordinate
  #     x2 : second line X coordinate
  #     y2 : second line Y coordinate
  #     color1 : fill color 1 of the line
  #     width : line width
  #     color2 : fill color 2 of the line (used for gradient) 
  #     vertical : true to have a vertical gradient, else false
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, x1, y1, x2, y2, color1, width=1, color2=color1, vertical=false,
                 active=true, visible=true)
    super(window, active, visible)
    self.x1 = x1
    self.y1 = y1
    self.x2 = x2
    self.y2 = y2
    self.width = width
    self.color1 = color1
    self.color2 = color2
    self.vertical = vertical
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible  
      c1 = self.color1
      c2 = self.color2
      gradient = c1 != c2
      if !active
        if gradient
          c1 = Color.inactive_gauge_color1
          c2 = Color.inactive_gauge_color2
        else
          c1 = c2 = Color.gauge_back_color
        end
      end

      bitmap.draw_line(self.x1, self.y1, self.x2, self.y2, 
                                  c1, self.width, c2, self.vertical)

    end
  end

end

#==============================================================================
# ** CEllipse
#------------------------------------------------------------------------------
#  Represents an Ellipse control on a window
#==============================================================================

class CEllipse < CDrawingObject
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Coordinates (X,Y) of the center of the ellipse
  attr_accessor :x, :y
  # Distance from center to right side
  attr_accessor :a
  # Distance from center to top side
  attr_accessor :b
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the ellipse will be drawn
  #     x : center of the ellipse X coordinate
  #     y : center of the ellipse Y coordinate
  #     a : distance from center to right side
  #     b : distance from center to top side
  #     color1 : fill color 1 of the ellipse
  #     filled : true to draw a filled ellipse, else false
  #     color2 : fill color 2 of the ellipse (used for gradient) 
  #     border : size of the border
  #     br_color1 : border color 1 of the ellipse
  #     br_color2 : border color 2 of the ellipse (used for gradient) 
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, x, y, a, b, color1, filled=true, color2=color1, 
                 border=0, br_color1=color1, br_color2=br_color1,
                 active=true, visible=true)
    super(window, color1, filled, color2, 
          border, br_color1, br_color2, 
          active, visible)
    self.x = x
    self.y = y
    self.a = a
    self.b = b
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible     
      c1 = self.color1
      c2 = self.color2
      br_c1 = self.br_color1
      br_c2 = self.br_color2
      gradient = (c1 != c2)
      br_gradient = (br_c1 != br_c2)
      if !active
        if gradient
          c1 = Color.inactive_gauge_color1
          c2 = Color.inactive_gauge_color2
        else
          c1 = c2 = Color.gauge_back_color
        end
        
        if br_gradient
          br_c1 = Color.inactive_gauge_color1
          br_c2 = Color.inactive_gauge_color2
        else
          br_c1 = br_c2 = Color.normal_color
        end
      end
      
      if filled
        bitmap.draw_filled_ellipse(self.x, self.y, self.a, self.b, c1, c2)
      end
      
      if border > 0
        bitmap.draw_ellipse(self.x, self.y, self.a, self.b, br_c1, 
                                    self.border, br_c2)
      end
      
    end
  end
  
end

#==============================================================================
# ** Window_Base
#------------------------------------------------------------------------------
#  This is a superclass of all windows in the game.
#==============================================================================

class Window_Base < Window

  #//////////////////////////////////////////////////////////////////////////
  # * Constants
  #//////////////////////////////////////////////////////////////////////////
  OPEN = "OPEN"
  SLIDE = "SLIDE"
  FADE = "FADE"
  MOVE = "MOVE"
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Animation speed (in milliseconds)
  attr_reader :animationSpeed
    
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set the animation speed
  #--------------------------------------------------------------------------
  def animationSpeed=(animationSpeed)
    @animationSpeed = animationSpeed.to_f/1000 * 60
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x      : window x-coordinate
  #     y      : window y-coordinate
  #     width  : window width
  #     height : window height
  #--------------------------------------------------------------------------
  alias initialize_ebjb initialize unless $@
  def initialize(x, y, width, height)
    initialize_ebjb(x, y, width, height)
    @animationType = nil
    self.animationSpeed = 100
    @duration = 0
    @orig_height = nil
    @orig_opacity = nil
    @move_x = @move_y = nil
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get * Text Color
  #--------------------------------------------------------------------------
  def normal_color; return Color.normal_color; end
  def system_color; return Color.system_color; end
  def crisis_color; return Color.crisis_color; end
  def lowmp_color; return Color.crisis_color; end
  def knockout_color; return Color.knockout_color; end
  def gauge_back_color; return Color.gauge_back_color; end
  def exhaust_color; return Color.gauge_back_color; end
  def hp_back_color; return Color.gauge_back_color; end
  def hp_gauge_color1; return Color.hp_gauge_color1; end
  def hp_gauge_color2; return Color.hp_gauge_color2; end
  def mp_back_color; return Color.gauge_back_color; end
  def mp_gauge_color1; return Color.mp_gauge_color1; end
  def mp_gauge_color2; return Color.mp_gauge_color2; end
  def power_up_color; return Color.power_up_color; end
  def power_down_color; return Color.power_down_color; end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    
    if @duration > 0
      @duration -= 1
      
      case @animationType
      # OPEN effect
      when OPEN
        if @opening
          open_effect(@duration, 255)
          @opening = false if @duration == 0
        elsif @closing
          open_effect(@duration, -255)
          @closing = false if @duration == 0
        end
      # SLIDE effect
      when SLIDE
        if @opening
          slide_effect(@duration, @orig_height)
          @opening = false if @duration == 0
        elsif @closing
          slide_effect(@duration, -@orig_height)
          if @duration == 0
            @closing = false
            self.visible = false
          end
        end  
      # FADE effect
      when FADE
        if @opening
          fade_effect(@duration, @orig_opacity)
          @opening = false if @duration == 0
        elsif @closing
          fade_effect(@duration, -@orig_opacity)
          if @duration == 0
            @closing = false
            self.visible = false
          end
        end   
      # MOVE effect
      when MOVE
        move_effect(@duration, @move_x, @move_y)
      end
      
      if @duration == 0
        @animationType = nil
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Open Window with the default effect
  #--------------------------------------------------------------------------
  def open
    if self.openness < 255
      @duration = self.animationSpeed
      @opening = true 
      @closing = false
      @animationType = OPEN
    end
  end
  
  #--------------------------------------------------------------------------
  # * Close window with the default effect
  #--------------------------------------------------------------------------
  def close
    if self.openness > 0
      @duration = self.animationSpeed
      @closing = true 
      @opening = false
      @animationType = OPEN
    end
  end
  
  #--------------------------------------------------------------------------
  # * Open window with a slide effect
  #--------------------------------------------------------------------------
  def slideDown
    if @orig_height == nil || self.height < @orig_height
      @duration = self.animationSpeed
      if @orig_height == nil
        @orig_height = self.height
      end
      self.height = 0
      self.visible = true
      @opening = true
      @closing = false
      @animationType = SLIDE
    end
  end
  
  #--------------------------------------------------------------------------
  # * Close window with a slide effect
  #--------------------------------------------------------------------------
  def slideUp
    if self.height > 0
      @duration = self.animationSpeed
      @orig_height = self.height
      @closing = true
      @opening = false
      @animationType = SLIDE
    end
  end
  
  #--------------------------------------------------------------------------
  # * Open window with a fade effect
  #--------------------------------------------------------------------------
  def fadeIn
    if @orig_opacity == nil || self.opacity < @orig_opacity
      @duration = self.animationSpeed
      if @orig_opacity == nil
        @orig_opacity = self.opacity
      end
      self.opacity = 0
      self.visible = true
      @opening = true
      @closing = false
      @animationType = FADE
    end
  end
  
  #--------------------------------------------------------------------------
  # * Close window with a fade effect
  #--------------------------------------------------------------------------
  def fadeOut
    if self.opacity > 0
      @duration = self.animationSpeed
      @orig_opacity = self.opacity
      @closing = true
      @opening = false
      @animationType = FADE
    end
  end

  #--------------------------------------------------------------------------
  # * Open window with a move effect
  #--------------------------------------------------------------------------
  def moveTo(x, y)
    # If not necessary because you can always use moveTo
    @duration = self.animationSpeed
    @move_x = x - self.x
    @move_y = y - self.y
    @animationType = MOVE
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Open effect
  #     duration : effect duration
  #     openness : openness
  #--------------------------------------------------------------------------
  def open_effect(duration, openness)
    if @temp_basic_step_openness == nil
      @temp_basic_step_openness = openness / duration.to_f
      
      @we_open_start_openness = self.openness
    end

    step_openness = openness - (duration * @temp_basic_step_openness)
    
    self.openness = @we_open_start_openness + step_openness

    if duration == 0
      @temp_basic_step_openness = nil
      @we_open_start_openness = nil
    end
  end
  private :open_effect

  #--------------------------------------------------------------------------
  # * Slide effect
  #     duration : effect duration
  #     height : height
  #--------------------------------------------------------------------------
  def slide_effect(duration, height)
    if @temp_basic_step_height == nil
      @temp_basic_step_height = height / duration.to_f
      
      @we_open_start_height = self.height
    end

    step_height = height - (duration * @temp_basic_step_height)
    
    self.height = @we_open_start_height + step_height

    if duration == 0
      @temp_basic_step_height = nil
      @we_open_start_height = nil
    end
  end
  private :slide_effect
  
  #--------------------------------------------------------------------------
  # * Fade effect
  #     duration : effect duration
  #     opacity : opacity
  #--------------------------------------------------------------------------
  def fade_effect(duration, opacity)
    if @temp_basic_step_opacity == nil
      @temp_basic_step_opacity = opacity / duration.to_f
      
      @we_open_start_opacity = self.opacity
    end

    step_opacity = opacity - (duration * @temp_basic_step_opacity)
    
    self.opacity = @we_open_start_opacity + step_opacity

    if duration == 0
      @temp_basic_step_opacity = nil
      @we_open_start_opacity = nil
    end
  end
  private :fade_effect
  
  #--------------------------------------------------------------------------
  # * Move effect
  #     duration : effect duration
  #     x : X coordinate to move to
  #     y : Y coordinate to move to
  #--------------------------------------------------------------------------
  def move_effect(duration, x, y)
    if @temp_basic_step_x == nil && @temp_basic_step_y == nil
      @temp_basic_step_x = x / duration.to_f
      @temp_basic_step_y = y / duration.to_f
      
      @we_move_start_x = self.x
      @we_move_start_y = self.y
    end
    
    step_x = x - (duration * @temp_basic_step_x)
    step_y = y - (duration * @temp_basic_step_y)

    self.x = @we_move_start_x + step_x
    self.y = @we_move_start_y + step_y

    if duration == 0
      @temp_basic_step_x = nil
      @temp_basic_step_y = nil
      @we_move_start_x = nil
      @we_move_start_y = nil
    end
  end
  private :move_effect
  
end

#==============================================================================
# ** Window_Scrollable
#------------------------------------------------------------------------------
#  This window contains scroll functions
#==============================================================================

class Window_Scrollable < Window_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Scroll speed
  attr_accessor :scroll_speed
  # True to scroll horizontally, else false
  attr_accessor :horizontal_scroll
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #     width : window width
  #     height : window height
  #     scroll_speed : scroll speed
  #     horizontal_scroll : true to scroll horizontally, else false
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, scroll_speed=8, horizontal_scroll=false)
    super(x, y, width, height)
    self.scroll_speed = scroll_speed
    self.horizontal_scroll = horizontal_scroll
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Frame update
  #--------------------------------------------------------------------------
  def update
    super
    if self.active
      if !horizontal_scroll
        # Scroll vertically
        scroll_max = [self.contents.height - (self.height - 32), 0].max
        if Input.press?(Input::UP)
          self.oy = [self.oy - self.scroll_speed, 0].max
        elsif Input.press?(Input::DOWN)
          self.oy = [self.oy + self.scroll_speed, scroll_max].min
        elsif Input.repeat?(Input::L)
          self.oy = [self.oy - (self.height - 32), 0].max
        elsif Input.repeat?(Input::R)
          self.oy = [self.oy + (self.height - 32), scroll_max].min
        end
      else
        # Scroll horizontally
        scroll_max = [self.contents.width - (self.width - 32), 0].max
        if Input.press?(Input::LEFT)
          self.ox = [self.ox - self.scroll_speed, 0].max
        elsif Input.press?(Input::RIGHT)
          self.ox = [self.ox + self.scroll_speed, scroll_max].min
        elsif Input.repeat?(Input::L)
          self.ox = [self.ox - (self.width - 32), 0].max
        elsif Input.repeat?(Input::R)
          self.ox = [self.ox + (self.width - 32), scroll_max].min
        end
      end
    end
  end
  
end

#==============================================================================
# ** Window_Info_Help
#------------------------------------------------------------------------------
#  This window shows different types of help or explanations
#==============================================================================

class Window_Info_Help < Window_Scrollable
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control for the text to display
  attr_reader :cText
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #     width : window width
  #     height : window height
  #     text : text to display
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, text)
    super(x, y, width, height)
    
    @cText = CLabel.new(self, Rect.new(0,0,self.contents.width,WLH), "")
    @cText.multiline = true
    @cText.multiline_resize = true
    
    window_update(text)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update
  #     text : new text to display
  #--------------------------------------------------------------------------
  def window_update(text)
    if text != nil
      @cText.text = text
    end
    refresh()
  end
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh()
    self.contents.clear
    @cText.draw()
  end
  
end
#==============================================================================
# ** Window_Details
#------------------------------------------------------------------------------
#  This window shows the details of an item
#==============================================================================

class Window_Details < Window_Base
  include EBJB
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Array containing the icon indexes for the Scope stat
  attr_accessor :scopeIcons
  # Array containing the icon indexes for the Occasion stat
  attr_accessor :occasionIcons
  # Array containing the icon indexes for Bonus stat
  attr_accessor :bonusIcons
  # Number of icons to show at the same time
  attr_accessor :maxIcons
  # Timeout in seconds before switching icons
  attr_accessor :iconsTimeout
  # Pattern used to show the value of the Recovery effect
  attr_accessor :recoveryPattern
  # Sign for plus state set
  attr_accessor :statesPlusSign
  # Sign for minus state set
  attr_accessor :statesMinusSign
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #     width : window width
  #     height : window height
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height)
    super(x, y, width, height)
    
    @scopeIcons = CORE_CONFIG::DEFAULT_SCOPE_ICONS
    @occasionIcons = CORE_CONFIG::DEFAULT_OCCASION_ICONS
    @bonusIcons = CORE_CONFIG::DEFAULT_BONUS_ICONS
    @maxIcons = CORE_CONFIG::DEFAULT_MAX_ICONS
    @iconsTimeout = CORE_CONFIG::DEFAULT_ICONS_TIMEOUT
    @recoveryPattern = CORE_CONFIG::DEFAULT_REC_PATTERN
    @statesPlusSign = CORE_CONFIG::DEFAULT_STATES_PLUS_SIGN
    @statesMinusSign = CORE_CONFIG::DEFAULT_STATES_MINUS_SIGN
  end
  
end

#==============================================================================
# ** Window_ItemDetails
#------------------------------------------------------------------------------
#  This window shows the details of an item
#==============================================================================

class Window_ItemDetails < Window_Details

  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # UCLabelIcon for the item icon and name
  attr_reader :ucItemInfo
  # CLabel for Recovery effect
  attr_reader :cRecLabel
  # UCLabelValue for the HP Recovery effect of the item
  attr_reader :ucRecHPStat
  # UCLabelValue for the MP Recovery effect of the item
  attr_reader :ucRecMPStat
  # CLabel for Damage effect 
  attr_reader :cDmgLabel
  # UCLabelValue for the HP Damage effect of the item
  attr_reader :ucDmgHPStat
  # UCLabelValue for the MP Damage effect of the item
  attr_reader :ucDmgMPStat
  # Icons list for the scope of the item
  attr_reader :ucScopeStat
  # Icons list for the elements of the item
  attr_reader :ucElementsStat
  # CLabel for States
  attr_reader :cStatesLabel
  # Icons list for the states of the item
  attr_reader :ucStatesStat

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #     width : window width
  #     height : window height
  #     item : item object
  #     spacing : spacing between stats
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, item, spacing = 10)
    super(x, y, width, height)

    @ucItemInfo = UCLabelIcon.new(self, Rect.new(32,0,180,WLH), 
                                  Rect.new(0,0,24,WLH), "", 0, 0)
    
    @cRecLabel = CLabel.new(self, Rect.new(0,40,80,WLH), Vocab::recovery_label)
    @ucRecHPStat = UCLabelValue.new(self, Rect.new(80+spacing,34,20,WLH), 
                                    Rect.new(100+spacing,34,78,WLH), Vocab::hp_label, 0)
    @ucRecHPStat.cLabel.font = Font.item_details_stats_font
    @ucRecHPStat.cValue.font = Font.item_details_stats_font
    @ucRecMPStat = UCLabelValue.new(self, Rect.new(80+spacing,46,20,WLH), 
                                    Rect.new(100+spacing,46,78,WLH), Vocab::mp_label, 0)
    @ucRecMPStat.cLabel.font = Font.item_details_stats_font
    @ucRecMPStat.cValue.font = Font.item_details_stats_font

    @cDmgLabel = CLabel.new(self, Rect.new(236,40,80,WLH), Vocab::damage_label)
    @ucDmgHPStat = UCLabelValue.new(self, Rect.new(316+spacing,34,20,WLH), 
                                    Rect.new(336+spacing,34,60,WLH), Vocab::hp_label, 0)
    @ucDmgHPStat.cLabel.font = Font.item_details_stats_font
    @ucDmgHPStat.cValue.font = Font.item_details_stats_font
    @ucDmgMPStat = UCLabelValue.new(self, Rect.new(316+spacing,46,20,WLH), 
                                    Rect.new(336+spacing,46,60,WLH), Vocab::mp_label, 0)
    @ucDmgMPStat.cLabel.font = Font.item_details_stats_font
    @ucDmgMPStat.cValue.font = Font.item_details_stats_font

    @ucScopeStat = UCLabelIconsList.new(self, Rect.new(430,40,80,WLH),
                                        Rect.new(510,40,100,WLH), Vocab::scopes_label, [0])
    
    @ucElementsStat = UCLabelIconsSwitchableList.new(self, Rect.new(236,0,80,WLH),
                                         Rect.new(326,0,100,WLH), Vocab::elements_label, [0],
                                         self.maxIcons, self.iconsTimeout)
    @cStatesLabel = CLabel.new(self, Rect.new(430,0,80,WLH), Vocab::states_label)
    @ucStatesStat = UCLabelIconControlsSwitchableList.new(Rect.new(510,0,50,WLH), [],
                                         self.maxIcons, self.iconsTimeout)

    window_update(item)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update
  #     item : item object
  #--------------------------------------------------------------------------
  def window_update(item)
    if item != nil
      @ucItemInfo.cLabel.text = item.name
      @ucItemInfo.ucIcon.iconIndex = item.icon_index
      @ucRecHPStat.cValue.text = sprintf(self.recoveryPattern, item.hp_recovery_rate, item.hp_recovery)
      @ucRecMPStat.cValue.text = sprintf(self.recoveryPattern, item.mp_recovery_rate, item.mp_recovery)
      if item.damage_to_mp
        @ucDmgHPStat.cValue.text = 0
        @ucDmgMPStat.cValue.text = item.base_damage
      else
        @ucDmgHPStat.cValue.text = item.base_damage
        @ucDmgMPStat.cValue.text = 0
      end
      
      iconsArray = []
      iconsArray.push(self.scopeIcons[item.scope])
      iconsArray.push(self.occasionIcons[item.occasion])
      @ucScopeStat.icons = iconsArray

      iconsArray = []
      for i in 0 .. item.element_set.size-1
        iconsArray[i] = $data_elements[item.element_set[i]].icon_index
      end
      @ucElementsStat.icons = iconsArray

      controlsArray = []
      baseX = @ucStatesStat.rectControls.x
      for i in 0 .. item.plus_state_set.size-1
        temp = UCLabelIcon.new(self, Rect.new(baseX,-6,24,24), Rect.new(baseX,0,24,24), 
                               self.statesPlusSign, $data_states[item.plus_state_set[i]].icon_index)
        temp.cLabel.font = Font.item_details_plus_states_font
        controlsArray.push(temp)
      end
      for i in 0 .. item.minus_state_set.size-1
        temp = UCLabelIcon.new(self, Rect.new(baseX,-6,24,24), Rect.new(baseX,0,24,24), 
                               self.statesMinusSign, $data_states[item.minus_state_set[i]].icon_index)
        temp.cLabel.font = Font.item_details_minus_states_font
        controlsArray.push(temp)
      end
      @ucStatesStat.controls = controlsArray
    end
    refresh()
  end
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh()
    self.contents.clear
    @ucItemInfo.draw()
    @cRecLabel.draw()
    @ucRecHPStat.draw()
    @ucRecMPStat.draw()
    @cDmgLabel.draw()
    @ucDmgHPStat.draw()
    @ucDmgMPStat.draw()
    @ucScopeStat.draw()
    @ucElementsStat.draw()
    @cStatesLabel.draw()
    @ucStatesStat.draw()
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update (for the icons list that refreshed after a timeout)
  #--------------------------------------------------------------------------
  def update
    super
    @ucElementsStat.update()
    @ucStatesStat.update()
  end
  
end

#==============================================================================
# ** Window_EquipDetails
#------------------------------------------------------------------------------
#  This window shows the details of an equippable item
#==============================================================================

class Window_EquipDetails < Window_Details
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # UCLabelIcon for the item icon and name
  attr_reader :ucItemInfo
  # CLabel for Stats
  attr_reader :cStatsLabel
  # UCLabelValue for the HP stat of the item
  attr_reader :ucHPStat
  # UCLabelValue for the MP stat of the item
  attr_reader :ucMPStat
  # UCLabelValue for the ATK stat of the item
  attr_reader :ucAtkStat
  # UCLabelValue for the DEF stat of the item
  attr_reader :ucDefStat
  # UCLabelValue for the SPI stat of the item
  attr_reader :ucSpiStat
  # UCLabelValue for the AGI stat of the item
  attr_reader :ucAgiStat
  # UCLabelValue for the HIT stat of the item
  attr_reader :ucHitStat
  # UCLabelValue for the EVA stat of the item
  attr_reader :ucEvaStat
  # Icons list for the bonuses of the item
  attr_reader :ucBonusesStat
  # Icons list for the elements of the item
  attr_reader :ucElementsStat
  # CLabel for States
  attr_reader :cStatesLabel
  # Icons list for the states of the item
  attr_reader :ucStatesStat
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #     width : window width
  #     height : window height
  #     item : item object
  #     spacing : spacing between stats
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, item, spacing = 10)
    super(x, y, width, height)

    @ucItemInfo = UCLabelIcon.new(self, Rect.new(32,0,180,WLH), 
                                Rect.new(0,0,24,WLH), "", 0, 0)
    
    @cStatsLabel = CLabel.new(self, Rect.new(0,40,80,WLH), Vocab::stats_label)
    
    @ucHPStat = UCLabelValue.new(self, Rect.new(80+spacing,34,30,WLH), 
                                 Rect.new(110+spacing,34,48,WLH), Vocab::hp_label, 0)
    @ucHPStat.cLabel.font = Font.item_details_stats_font
    @ucHPStat.cValue.font = Font.item_details_stats_font
    @ucMPStat = UCLabelValue.new(self, Rect.new(80+spacing,46,30,WLH), 
                                 Rect.new(110+spacing,46,48,WLH), Vocab::mp_label, 0)
    @ucMPStat.cLabel.font = Font.item_details_stats_font
    @ucMPStat.cValue.font = Font.item_details_stats_font
    
    @ucAtkStat = UCLabelValue.new(self, Rect.new(158+spacing*2,34,30,WLH), 
                                  Rect.new(188+spacing*2,34,48,WLH), Vocab::atk_label, 0)
    @ucAtkStat.cLabel.font = Font.item_details_stats_font
    @ucAtkStat.cValue.font = Font.item_details_stats_font
    @ucDefStat = UCLabelValue.new(self, Rect.new(158+spacing*2,46,30,WLH), 
                                  Rect.new(188+spacing*2,46,48,WLH), Vocab::def_label, 0)
    @ucDefStat.cLabel.font = Font.item_details_stats_font
    @ucDefStat.cValue.font = Font.item_details_stats_font
    
    @ucSpiStat = UCLabelValue.new(self, Rect.new(236 + spacing*3,34,30,WLH), 
                                  Rect.new(266 + spacing*3,34,48,WLH), Vocab::spi_label, 0)
    @ucSpiStat.cLabel.font = Font.item_details_stats_font
    @ucSpiStat.cValue.font = Font.item_details_stats_font
    @ucAgiStat = UCLabelValue.new(self, Rect.new(236 + spacing*3,46,30,WLH), 
                                  Rect.new(266 + spacing*3,46,48,WLH), Vocab::agi_label, 0)
    @ucAgiStat.cLabel.font = Font.item_details_stats_font
    @ucAgiStat.cValue.font = Font.item_details_stats_font
    
    @ucHitStat = UCLabelValue.new(self, Rect.new(314 + spacing*4,34,30,WLH), 
                                  Rect.new(344 + spacing*4,34,48,WLH), Vocab::hit_label, 0)
    @ucHitStat.cLabel.font = Font.item_details_stats_font
    @ucHitStat.cValue.font = Font.item_details_stats_font
    @ucEvaStat = UCLabelValue.new(self, Rect.new(314 + spacing*4,46,30,WLH), 
                                  Rect.new(344  + spacing*4,46,48,WLH), Vocab::eva_label, 0)
    @ucEvaStat.cLabel.font = Font.item_details_stats_font
    @ucEvaStat.cValue.font = Font.item_details_stats_font
    
    @ucBonusesStat = UCLabelIconsList.new(self, Rect.new(430,40,80,WLH),
                                        Rect.new(510,40,100,WLH), Vocab::bonus_label, [0])

    @ucElementsStat = UCLabelIconsSwitchableList.new(self, Rect.new(236,0,80,WLH),
                                         Rect.new(326,0,100,WLH), Vocab::elements_label, [0],
                                         self.maxIcons, self.iconsTimeout)
    @cStatesLabel = CLabel.new(self, Rect.new(430,0,80,WLH), Vocab::states_label)
    @ucStatesStat = UCLabelIconControlsSwitchableList.new(Rect.new(510,0,50,WLH), [],
                                         self.maxIcons, self.iconsTimeout)

    window_update(item)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update
  #     item : item object
  #--------------------------------------------------------------------------
  def window_update(item)
    if item != nil
      @ucItemInfo.cLabel.text = item.name
      @ucItemInfo.ucIcon.iconIndex = item.icon_index
      @ucHPStat.cValue.text = 0
      @ucMPStat.cValue.text = 0
      @ucAtkStat.cValue.text = item.atk
      @ucDefStat.cValue.text = item.def
      @ucSpiStat.cValue.text = item.spi
      @ucAgiStat.cValue.text = item.agi
      if item.is_a?(RPG::Weapon)
        @ucHitStat.cValue.text = item.hit
        @ucEvaStat.cValue.text = 0
      else 
        @ucHitStat.cValue.text = 0
        @ucEvaStat.cValue.text = item.eva
      end

      iconsArray = []
      if item.is_a?(RPG::Weapon)
        iconsArray.push(self.bonusIcons[0]) if item.two_handed
        iconsArray.push(self.bonusIcons[1]) if item.critical_bonus
      else
        iconsArray.push(self.bonusIcons[2]) if item.prevent_critical 
        iconsArray.push(self.bonusIcons[3]) if item.half_mp_cost
      end
      @ucBonusesStat.icons = iconsArray

      iconsArray = []
      for i in 0 .. item.element_set.size-1
        iconsArray[i] = $data_elements[item.element_set[i]].icon_index
      end
      @ucElementsStat.icons = iconsArray

      controlsArray = []
      baseX = @ucStatesStat.rectControls.x
      for i in 0 .. item.state_set.size-1
        temp = UCLabelIcon.new(self, Rect.new(baseX,-6,24,24), Rect.new(baseX,0,24,24), 
                               nil, $data_states[item.state_set[i]].icon_index)

        if item.is_a?(RPG::Weapon)
          temp.cLabel.text = self.statesPlusSign
          temp.cLabel.font = Font.item_details_plus_states_font
        else
          temp.cLabel.text = self.statesMinusSign
          temp.cLabel.font = Font.item_details_minus_states_font
        end
        controlsArray.push(temp)
      end
      @ucStatesStat.controls = controlsArray
    end
    refresh()
  end
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh()
    self.contents.clear
    @ucItemInfo.draw()
    @cStatsLabel.draw()
    @ucHPStat.draw()
    @ucMPStat.draw()
    @ucAtkStat.draw()
    @ucDefStat.draw()
    @ucSpiStat.draw()
    @ucAgiStat.draw()
    @ucHitStat.draw()
    @ucEvaStat.draw()
    @ucBonusesStat.draw()
    @ucElementsStat.draw()
    @cStatesLabel.draw()
    @ucStatesStat.draw()
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update (for the icons list that refreshed after a timeout)
  #--------------------------------------------------------------------------
  def update
    super
    @ucElementsStat.update()
    @ucStatesStat.update()
  end
  
end

#==============================================================================
# ** Window_SkillDetails
#------------------------------------------------------------------------------
#  This window shows the details of a skill
#==============================================================================

class Window_SkillDetails < Window_Details
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # UCLabelIcon for the skill icon and name
  attr_reader :ucSkillInfo
  # CLabel for Damage effect 
  attr_reader :cDmgLabel
  # UCLabelValue for the HP Damage effect of the skill
  attr_reader :ucDmgHPStat
  # UCLabelValue for the MP Damage effect of the skill
  attr_reader :ucDmgMPStat
  # Icons list for the scope of the skill
  attr_reader :ucScopeStat
  # Icons list for the elements of the skill
  attr_reader :ucElementsStat
  # CLabel for States
  attr_reader :cStatesLabel
  # Icons list for the states of the skill
  attr_reader :ucStatesStat

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #     width : window width
  #     height : window height
  #     skill : skill object
  #     spacing : spacing between stats
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, skill, spacing = 10)
    super(x, y, width, height)

    @ucSkillInfo = UCLabelIcon.new(self, Rect.new(32,0,180,WLH), 
                                  Rect.new(0,0,24,WLH), "", 0, 0)
    
    @cDmgLabel = CLabel.new(self, Rect.new(0,40,80,WLH), Vocab::damage_label)
    @ucDmgHPStat = UCLabelValue.new(self, Rect.new(80+spacing,34,20,WLH), 
                                    Rect.new(100+spacing,34,60,WLH), Vocab::hp_label, 0)
    @ucDmgHPStat.cLabel.font = Font.skill_details_stats_font
    @ucDmgHPStat.cValue.font = Font.skill_details_stats_font
    @ucDmgMPStat = UCLabelValue.new(self, Rect.new(80+spacing,46,20,WLH), 
                                    Rect.new(100+spacing,46,60,WLH), Vocab::mp_label, 0)
    @ucDmgMPStat.cLabel.font = Font.skill_details_stats_font
    @ucDmgMPStat.cValue.font = Font.skill_details_stats_font

    @ucScopeStat = UCLabelIconsList.new(self, Rect.new(430,40,80,WLH),
                                        Rect.new(510,40,100,WLH), Vocab::scopes_label, [0])
    
    @ucElementsStat = UCLabelIconsSwitchableList.new(self, Rect.new(236,0,80,WLH),
                                         Rect.new(326,0,100,WLH), Vocab::elements_label, [0],
                                         self.maxIcons, self.iconsTimeout)
    @cStatesLabel = CLabel.new(self, Rect.new(430,0,80,WLH), Vocab::states_label)
    @ucStatesStat = UCLabelIconControlsSwitchableList.new(Rect.new(510,0,50,WLH), [],
                                         self.maxIcons, self.iconsTimeout)

    window_update(skill)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update
  #     skill : skill object
  #--------------------------------------------------------------------------
  def window_update(skill)
    if skill != nil
      @ucSkillInfo.cLabel.text = skill.name
      @ucSkillInfo.ucIcon.iconIndex = skill.icon_index

      if skill.damage_to_mp
        @ucDmgHPStat.cValue.text = 0
        @ucDmgMPStat.cValue.text = skill.base_damage
      else
        @ucDmgHPStat.cValue.text = skill.base_damage
        @ucDmgMPStat.cValue.text = 0
      end
      
      iconsArray = []
      iconsArray.push(self.scopeIcons[skill.scope])
      iconsArray.push(self.occasionIcons[skill.occasion])
      @ucScopeStat.icons = iconsArray

      iconsArray = []
      for i in 0 .. skill.element_set.size-1
        iconsArray[i] = $data_elements[skill.element_set[i]].icon_index
      end
      @ucElementsStat.icons = iconsArray

      controlsArray = []
      baseX = @ucStatesStat.rectControls.x
      for i in 0 .. skill.plus_state_set.size-1
        temp = UCLabelIcon.new(self, Rect.new(baseX,-6,24,24), Rect.new(baseX,0,24,24), 
                               self.statesPlusSign, $data_states[skill.plus_state_set[i]].icon_index)
        temp.cLabel.font = Font.item_details_plus_states_font
        controlsArray.push(temp)
      end
      for i in 0 .. skill.minus_state_set.size-1
        temp = UCLabelIcon.new(self, Rect.new(baseX,-6,24,24), Rect.new(baseX,0,24,24), 
                               self.statesMinusSign, $data_states[skill.minus_state_set[i]].icon_index)
        temp.cLabel.font = Font.item_details_minus_states_font
        controlsArray.push(temp)
      end
      @ucStatesStat.controls = controlsArray
    end
    refresh()
  end
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh()
    self.contents.clear
    @ucSkillInfo.draw()
    @cDmgLabel.draw()
    @ucDmgHPStat.draw()
    @ucDmgMPStat.draw()
    @ucScopeStat.draw()
    @ucElementsStat.draw()
    @cStatesLabel.draw()
    @ucStatesStat.draw()
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update (for the icons list that refreshed after a timeout)
  #--------------------------------------------------------------------------
  def update
    super
    @ucElementsStat.update()
    @ucStatesStat.update()
  end
  
end

#==============================================================================
# ** Window_Logo
#------------------------------------------------------------------------------
#  This window shows an image in background
#==============================================================================

class Window_Logo < Window_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control for the image in the background
  attr_reader :ucImage
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #     width : window width
  #     height : window height
  #     image : name of the image
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, image)
    super(x, y, width, height)
    
    @ucImage = UCBackgroundImage.new(self, "", 1, 128, 1)
    
    window_update(image)
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update
  #     image : new name of the image
  #--------------------------------------------------------------------------
  def window_update(image)
    if image != nil
      @ucImage.image = image
    end
    refresh()
  end
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh()
    self.contents.clear
    @ucImage.draw()
  end
  
end

#==============================================================================
# ** Window_Confirmation
#------------------------------------------------------------------------------
#  This window shows a Yes/No choice with a confirmation message
#==============================================================================

class Window_Confirmation < Window_Selectable
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control for the text to display
  attr_reader   :cText

  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Commands list
  @commands = nil
  # Default command index
  @default_index = nil
  # Number of lines for auto-height-resize
  @lines = nil
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #     width : window width
  #     text : text to display
  #     yes_command : YES command text (default Yes)
  #     no_command : NO command text (default No)
  #     default_index : default command index (No by default)
  #--------------------------------------------------------------------------
  def initialize(x, y, width, text, yes_command="Yes", no_command="No",
                 default_index=1)
    column_max = 2
    @commands = [yes_command, no_command]
    row_max = (@commands.size + column_max - 1) / column_max
    
    dummy = Bitmap.new(1,1)
    dummy.font = Font.bold_font
    @lines = dummy.split_multiline(Rect.new(0,0,width-32,WLH), text, 3).size
    dummy.dispose
    dummy = nil
    
    #row_max+lines to keep the text label over the commands
    super(x, y, width, (row_max+@lines) * WLH + 32, 32)
    @column_max = column_max
    @item_max = @commands.size
    @default_index = default_index
    @cText = CLabel.new(self, Rect.new(0,0,width-32,WLH), text, 1, Font.bold_font)
    @cText.multiline = true
    @cText.multiline_resize = true
    refresh
    self.index = @default_index
  end
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    self.contents.clear
    @cText.draw()
    # override the font of the label (because we can only change the font of
    # all of the contents in the window)
    self.contents.font = Font.normal_font
    for i in 0..@item_max-1
      draw_item(i)
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Show the confirmation window
  #--------------------------------------------------------------------------
  def show()
    self.active = true
    self.visible = true
  end
  
  #--------------------------------------------------------------------------
  # * Hide the confirmation window
  #--------------------------------------------------------------------------
  def hide()
    self.active = false
    self.visible = false
    self.index = @default_index
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw Item
  #     index : item number
  #--------------------------------------------------------------------------
  def draw_item(index)
    rect = item_rect(index)
    rect.x += 4
    rect.width -= 8
    self.contents.draw_text(rect, @commands[index])
  end
  private:draw_item
  
  #--------------------------------------------------------------------------
  # * Get rectangle for displaying items
  #     index : item number
  #--------------------------------------------------------------------------
  def item_rect(index)
    rect = Rect.new(0, 0, 0, 0)
    rect.width = (contents.width + @spacing) / @column_max - @spacing
    rect.height = WLH
    rect.x = index % @column_max * (rect.width + @spacing)
    # WLH is added for each line to draw the items below the multiline label
    rect.y = (@lines*WLH) + (index / @column_max * WLH)
    return rect
  end
  private:item_rect

end

#==============================================================================
# ** Window_Selectable Addon
#------------------------------------------------------------------------------
#  Addon functions for cursor movement and scroll
#==============================================================================

class Window_Selectable < Window_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Window line height
  attr_reader   :line_h
  # True to show the cursor, else false
  attr_reader   :visible_cursor
  # True to block cursor from moving, else false
  attr_writer   :block_cursor
  # Items alignment
  #   0 - Left
  #   1 - Middle
  #   2 - Right
  attr_reader   :align
  # Pointer on the detail window
  attr_reader   :detail_window
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # True to select all items with the cursor, else false
  @select_all = false
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x       : window X coordinate
  #     y       : window Y coordinate
  #     width   : window width
  #     height  : window height
  #     spacing : width of empty space when items are arranged horizontally
  #     line_h  : window line height
  #     visible_cursor : true to show the cursor, else false
  #     line_w  : window line width
  #     align : items alignment
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, spacing = 32, line_h = WLH, 
                 visible_cursor = true, line_w = 0, align = 0)
    @block_cursor = false
    @item_max = 1
    @column_max = 1
    @index = -1
    @spacing = spacing
    @line_h = line_h
    @visible_cursor = visible_cursor
    @line_w = line_w
    @align = align
    super(x, y, width, height)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set Cursor Position
  #--------------------------------------------------------------------------
  def index=(index)
    @select_all = false
    @block_cursor = false
    @index = index
    update_cursor
    call_update_help
    if @detail_window != nil
      if !self.is_switchable && @detail_window.visible
        switch_windows()
      end
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Create Window Contents
  #--------------------------------------------------------------------------
  def create_contents
    self.contents.dispose
    self.contents = Bitmap.new(width - 32, [height - 32, row_max * @line_h].max)
  end
  
  #--------------------------------------------------------------------------
  # * Determine if cursor is moveable
  #--------------------------------------------------------------------------
  alias cursor_movable_ebjb? cursor_movable? unless $@
  def cursor_movable?
    return false if @block_cursor
    return false if @select_all
    return cursor_movable_ebjb?
  end
  
  #--------------------------------------------------------------------------
  # * Get Top Row
  #--------------------------------------------------------------------------
  def top_row
    return self.oy / @line_h
  end
  
  #--------------------------------------------------------------------------
  # * Set Top Row
  #     row : row shown on top
  #--------------------------------------------------------------------------
  def top_row=(row)
    row = 0 if row < 0
    row = row_max - 1 if row > row_max - 1
    self.oy = row * @line_h
  end
  
  #--------------------------------------------------------------------------
  # * Get Number of Rows Displayable on 1 Page
  #--------------------------------------------------------------------------
  def page_row_max
    return (self.height - 32) / @line_h
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor down
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_down(wrap = false)
    if (@index < @item_max - @column_max) or (wrap and @column_max == 1)
      Sound.play_cursor
      self.index = (@index + @column_max) % @item_max
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor up
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_up(wrap = false)
    if (@index >= @column_max) or (wrap and @column_max == 1)
      Sound.play_cursor
      self.index = (@index - @column_max + @item_max) % @item_max
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor right
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_right(wrap = false)
    if (@column_max >= 2) and
       (@index < @item_max - 1 or (wrap and page_row_max == 1))
      Sound.play_cursor
      self.index = (@index + 1) % @item_max
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor left
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_left(wrap = false)
    if (@column_max >= 2) and
       (@index > 0 or (wrap and page_row_max == 1))
      Sound.play_cursor
      self.index = (@index - 1 + @item_max) % @item_max
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor one page down
  #--------------------------------------------------------------------------
  def cursor_pagedown
    if top_row + page_row_max < row_max
      Sound.play_cursor
      self.top_row += page_row_max
      self.index = [@index + page_item_max, @item_max - 1].min
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor one page up
  #--------------------------------------------------------------------------
  def cursor_pageup
    if top_row > 0
      Sound.play_cursor
      self.top_row -= page_row_max
      self.index = [@index - page_item_max, 0].max
    end
  end
  
  #--------------------------------------------------------------------------
  # * Select all items with the cursor
  #--------------------------------------------------------------------------
  def cursor_select_all
    @select_all = true
    update_cursor
  end
  
  #--------------------------------------------------------------------------
  # * Get rectangle for displaying items
  #     index : item number
  #     adjust_rect_x : true to adjust rect (x, width only) when cursor is visible to avoid
  #                   drawn controls to override cursor, else false 
  #     adjust_rect_y : true to adjust rect (y, height only) when cursor is visible to avoid
  #                   drawn controls to override cursor, else false 
  #--------------------------------------------------------------------------
  def item_rect(index, adjust_rect_x=false, adjust_rect_y=false)
    rect = Rect.new(0, 0, 0, 0)
    if @line_w > 0
      rect.width = @line_w
    else
      rect.width = (contents.width + @spacing) / @column_max - @spacing
    end
    rect.height = @line_h
    
    x = index % @column_max * (rect.width + @spacing)

    if @line_w > 0
      case @align 
        when 0 # Left
          rect.x = x
        when 1 # Middle
          rect.x = x + contents.width/2 - (@column_max * (rect.width + @spacing))/2
        when 2 # Right
          rect.x = x + contents.width - (@column_max * (rect.width + @spacing))
        else
          rect.x = 0
      end
    end
    
    rect.y = index / @column_max * @line_h
    
    if adjust_rect_x && @visible_cursor
      rect.x += 2
      rect.width -= 4
    end
    
    if adjust_rect_y && @visible_cursor
      rect.y += 2
      rect.height -= 4
    end
    
    return rect
  end
  
  #--------------------------------------------------------------------------
  # * Update cursor
  #--------------------------------------------------------------------------
  def update_cursor      
    if @index < 0                   # If the cursor position is less than 0
      self.cursor_rect.empty        # Empty cursor
    else                            # If the cursor position is 0 or more
      row = @index / @column_max    # Get current row
      if row < top_row              # If before the currently displayed
        self.top_row = row          # Scroll up
      end
      if row > bottom_row           # If after the currently displayed
        self.bottom_row = row       # Scroll down
      end
      if @visible_cursor
        if @select_all
          self.cursor_rect = Rect.new(0,0,self.contents.width, self.contents.height)
        else
          rect = item_rect(@index)      # Get rectangle of selected item
          rect.y -= self.oy             # Match rectangle to scroll position
          self.cursor_rect = rect       # Refresh cursor rectangle
        end
      else
        self.cursor_rect.empty 
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    if cursor_movable?
      if Input.repeat?(Input::DOWN)
        cursor_down(Input.trigger?(Input::DOWN))
      end
      if Input.repeat?(Input::UP)
        cursor_up(Input.trigger?(Input::UP))
      end
      if Input.repeat?(Input::RIGHT)
        cursor_right(Input.trigger?(Input::RIGHT))
      end
      if Input.repeat?(Input::LEFT)
        cursor_left(Input.trigger?(Input::LEFT))
      end
      if Input.repeat?(Input::R)
        cursor_pagedown
      end
      if Input.repeat?(Input::L)
        cursor_pageup
      end
    end
    
    if Input.trigger?(Input::X)
      if self.active && self.is_switchable
        switch_windows()
      end
    end
    
  end
  
  #--------------------------------------------------------------------------
  # * Gets current data
  #--------------------------------------------------------------------------
  def current_data
    return @data
  end
  
  #--------------------------------------------------------------------------
  # * Set Detail Window
  #     detail_window : new detail window
  #--------------------------------------------------------------------------
  def detail_window=(detail_window)
    @detail_window = detail_window
    call_update_detail
  end
  
  #--------------------------------------------------------------------------
  # * Call detail window update method
  #--------------------------------------------------------------------------
  def call_update_detail
    if self.active and @detail_window != nil and self.is_switchable
       update_detail
    end
  end
  
  #--------------------------------------------------------------------------
  # * Update detail window (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def update_detail
  end
  
  #--------------------------------------------------------------------------
  # * Determine if help/detail window can be switched (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def is_switchable
  end
  
  #--------------------------------------------------------------------------
  # * Alias call help window update method
  #--------------------------------------------------------------------------
  alias call_update_help_ebjb call_update_help unless $@
  def call_update_help
    call_update_help_ebjb
    call_update_detail
  end
  
  #--------------------------------------------------------------------------
  # * Switch help/detail window
  #--------------------------------------------------------------------------
  def switch_windows
    if @help_window != nil && @detail_window != nil
      @help_window.visible = !@help_window.visible
      @detail_window.visible = !@detail_window.visible
    end
  end
  
end

#==============================================================================
# ** Window_Selectable_Headers
#------------------------------------------------------------------------------
#  This window adds headers to a Window_Selectable window
#==============================================================================

class Window_Selectable_Headers < Window_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Pointer on the window selectable which needs the headers
  attr_reader :selectable_window
  # Headers height
  attr_reader :header_height
  # Label controls list for the headers
  attr_reader :cHeaders
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set also the selectable window X property
  #--------------------------------------------------------------------------
  def x=(x)
    super(x)
    @selectable_window.x = x
  end
  
  #--------------------------------------------------------------------------
  # * Set also the selectable window Y property
  #--------------------------------------------------------------------------
  def y=(y)
    super(y)
    @selectable_window.y = y+@header_height+8
  end
  
  #--------------------------------------------------------------------------
  # * Set also the selectable window Z property
  #--------------------------------------------------------------------------
  def z=(z)
    super(z)
    @selectable_window.z = self.z + 1
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     selectable_window : window selectable which needs the headers
  #     header_height : headers height
  #--------------------------------------------------------------------------
  def initialize(selectable_window, header_height=WLH)
    @selectable_window = selectable_window
    @header_height = header_height
    super(selectable_window.x, selectable_window.y, 
          selectable_window.width, selectable_window.height+header_height+8)
    selectable_window.opacity = 0
    @cHeaders = []
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh()
    self.contents.clear
    @cHeaders.each() { |cHeader| cHeader.draw() }
  end
  
  #--------------------------------------------------------------------------
  # * Add new header
  #     text : text of the header
  #     x : x position of the header
  #     width : width of the header
  #     align : header alignment
  #     font : header font
  #--------------------------------------------------------------------------
  def addHeader(text, x, width, align=0, font=nil)
    @cHeaders.push(CLabel.new(self, Rect.new(x,0,width,@header_height), 
                              text, align, font))
  end
  
end

#==============================================================================
# ** Window_Custom_Selectable
#------------------------------------------------------------------------------
#  This window contains custom cursor movement functions
#==============================================================================

class Window_Custom_Selectable < Window_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Positions count
  attr_reader   :item_max
  # Array fo CursorPosition objects (see CursorPosition)
  attr_reader   :positions
  # Cursor position
  attr_reader   :index                   
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x       : window X coordinate
  #     y       : window Y coordinate
  #     width   : window width
  #     height  : window height
  #     positions : array of CursorPosition object
  #     isUpDown : true to move cursor Up/Down instead of Left/Right, else false
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, positions, isUpDown=false)
    super(x, y, width, height)
    @index = -1
    @positions = positions
    @item_max = positions.size if positions != nil
    @isUpDown = isUpDown
    self.index = 0 if positions != nil
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set Cursor Position
  #--------------------------------------------------------------------------
  def index=(index)
    @index = index
    update_cursor
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Determine if cursor is moveable
  #--------------------------------------------------------------------------
  def cursor_movable?
    return false if (not visible or not active)
    return false if (index < 0 or index > @item_max or @item_max == 0)
    return false if (@opening or @closing)
    return true
  end

  #--------------------------------------------------------------------------
  # * Move cursor right
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_right(wrap = false)
    if (@index < @item_max - 1 || wrap)

      temp_index = (@index + 1) % @item_max
      while !@positions[temp_index].enabled
        temp_index = (temp_index + 1) % @item_max
      end
      
      if (temp_index > @index || wrap)
        @index = temp_index
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor left
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_left(wrap = false)
    if (@index > 0 || wrap)

      temp_index = (@index - 1 + @item_max) % @item_max
      while !@positions[temp_index].enabled
        temp_index = (temp_index - 1 + @item_max) % @item_max
      end
      
      if (temp_index < @index || wrap)
        @index = temp_index
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    if cursor_movable?
      last_index = @index
      if !@isUpDown
        if Input.repeat?(Input::RIGHT)
          cursor_right(Input.trigger?(Input::RIGHT))
        end
        if Input.repeat?(Input::LEFT)
          cursor_left(Input.trigger?(Input::LEFT))
        end
      else
        if Input.repeat?(Input::UP)
          cursor_left(Input.trigger?(Input::UP))
        end
        if Input.repeat?(Input::DOWN)
          cursor_right(Input.trigger?(Input::DOWN))
        end
      end
      if @index != last_index
        Sound.play_cursor
        update_cursor
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Update cursor
  #--------------------------------------------------------------------------
  def update_cursor
    if @index < 0                   # If the cursor position is less than 0
      self.cursor_rect.empty        # Empty cursor
    else                            # If the cursor position is 0 or more
      self.cursor_rect = @positions[@index].rect  # Refresh cursor rectangle
    end
  end
  
end

#==============================================================================
# ** Window_Selectable_Multiple
#------------------------------------------------------------------------------
#  This window contains cursor movement and scroll functions for multiple selection
#==============================================================================

class Window_Selectable_Multiple < Window_Selectable
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Array containing the selected indexes
  attr_reader :indexes
  # Contains the id of the current selected index
  attr_reader :current_index
  # Number of selected indexes to keep
  attr_reader :max_indexes
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Return number of selected indexes
  #--------------------------------------------------------------------------
  # GET
  def nbr_selected_indexes
    result = 0
    for i in @indexes
      if i >= 0
        result += 1
      end
    end
    return result
  end
  
  #--------------------------------------------------------------------------
  # * Get a specific selected index
  #     i : index (in @indexes) of the selected index
  #--------------------------------------------------------------------------
  # GET
  def index(i=nil)
    temp = nil
    if i == nil
      if @index < 0
        temp = @indexes[0]
      else
        temp = @index
      end
    else
      temp = (i < 0 ? nil : @indexes[i])
    end
    return temp
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x       : window X coordinate
  #     y       : window Y coordinate
  #     width   : window width
  #     height  : window height
  #     spacing : width of empty space when items are arranged horizontally
  #     line_h  : window line height
  #     visiblecursor : true to show the cursor, else false
  #     line_w  : window line width
  #     align : items alignment
  #     max_indexes : number of selected indexes to keep
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, spacing = 32, line_h = WLH, 
                 visiblecursor = true, line_w = 0, align = 0, max_indexes = 2)
    super(x, y, width, height, spacing, line_h, visiblecursor, line_w, align)
    @max_indexes = max_indexes
    @indexes = Array.new(@max_indexes, -1)
    @cursor_sprites = Array.new(@max_indexes)
    @current_index = 0
    @item_max = 1
    @column_max = 1
    @index = -1
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update cursor
  #--------------------------------------------------------------------------
  alias update_cursor_ebjb update_cursor unless $@
  def update_cursor      
    update_cursor_ebjb
    if @visible_cursor

      for i in 0 .. @max_indexes-1
        if @indexes[i] >= 0
          if @cursor_sprites[i] != nil
            @cursor_sprites[i].bitmap.clear
          end
          if !@select_all
            rect = item_rect(@indexes[i])     # Get rectangle of selected item
            rect.y -= self.oy           # Match rectangle to scroll position
            cursor = Sprite.new
            cursor.x = self.x+rect.x+16
            cursor.y = self.y+rect.y+16
            cursor.z = 999
            cursor.opacity = 125
            cursor.bitmap = Bitmap.new(rect.width, rect.height)
            cursor.bitmap.stretch_blt(cursor.bitmap.rect, self.windowskin, Rect.new(64,64,32,32)) 
            @cursor_sprites[i] = cursor
          end
        end
      end
      
    end
  end
  
  #--------------------------------------------------------------------------
  # * Alias dispose
  #--------------------------------------------------------------------------
  alias dispose_ebjb dispose unless $@
  def dispose
    dispose_ebjb
    @cursor_sprites.each { |sprite| sprite.dispose if sprite != nil }
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    
    if Input.trigger?(Input::B)
      if self.active
        Sound.play_decision
        
        if @cursor_sprites[@current_index] != nil
          @cursor_sprites[@current_index].bitmap.clear
        end
        
        @indexes[@current_index] = -1
        if @current_index > 0
          @current_index -= 1
        end
        update_cursor
      end
      
    elsif Input.trigger?(Input::C)
      if self.active
        if @indexes.include?(@index) || block_selection
          Sound.play_buzzer
        else
          Sound.play_decision
          
          if @cursor_sprites[@current_index] != nil
            @cursor_sprites[@current_index].bitmap.clear
          end
          
          @indexes[@current_index] = @index
          if @current_index < @max_indexes-1
            @current_index += 1
          end
          update_cursor
        end
      end
    end
    
    for i in 0 .. @max_indexes-1
      if @indexes[i] >= 0
        row = @indexes[i] / @column_max    # Get row of index
        # If sprite is displayed on different row, hides it, else displays it
        if row < top_row || row > bottom_row
          @cursor_sprites[i].visible = false
        else
          @cursor_sprites[i].visible = true
        end
      end
    end
    
  end
  
  #--------------------------------------------------------------------------
  # * Empty the selected indexes
  #--------------------------------------------------------------------------
  def clean_indexes
    @indexes = Array.new(@max_indexes, -1)
    @cursor_sprites.each { |sprite| sprite.dispose if sprite != nil }
    @cursor_sprites = Array.new(@max_indexes)
    @current_index = 0
  end
  
  #--------------------------------------------------------------------------
  # * Block selection (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def block_selection
  end
  
end

#==============================================================================
# ** Sub_Scene_Base
#------------------------------------------------------------------------------
#  This is a superclass of all sub_scenes (reusable scenes) in the game
#==============================================================================

class Sub_Scene_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # True if the sub scene can be closed, else false
  # (can inform the main scene that the sub scene can be closed, for example,
  #  when there are no windows that are active in the sub scene)
  attr_reader :isClosable
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Start Processing (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def start
  end
  
  #--------------------------------------------------------------------------
  # * Termination Processing (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def terminate
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def update 
  end
  
  #--------------------------------------------------------------------------
  # * Show windows (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def show_windows
  end
  
  #--------------------------------------------------------------------------
  # * Hide windows (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def hide_windows
  end
  
end

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

#==============================================================================
# ** Font
#------------------------------------------------------------------------------
#  Contains the different fonts
#==============================================================================

class Font
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get Normal Font
  #--------------------------------------------------------------------------
  def self.normal_font
    f = Font.new()
    return f
  end
  
  #--------------------------------------------------------------------------
  # * Get Bold Font
  #--------------------------------------------------------------------------
  def self.bold_font
    f = Font.new()
    f.bold = true
    return f
  end
  
  #--------------------------------------------------------------------------
  # * Get Italic Font
  #--------------------------------------------------------------------------
  def self.italic_font
    f = Font.new()
    f.italic = true
    return f
  end

  #--------------------------------------------------------------------------
  # * Get Inactive Alpha Value
  #--------------------------------------------------------------------------
  def self.inactive_alpha
    return 128
  end
  
  #--------------------------------------------------------------------------
  # * Get Item Details Stats Font
  #--------------------------------------------------------------------------
  def self.item_details_stats_font
    f = Font.new()
    f.size = 12
    return f
  end
  
  #--------------------------------------------------------------------------
  # * Get Item Details Plus States Font
  #--------------------------------------------------------------------------
  def self.item_details_plus_states_font
    f = Font.new()
    f.color = Color.power_up_color()
    f.size = 20
    f.bold = true
    return f
  end
  
  #--------------------------------------------------------------------------
  # * Get Item Details Minus States Font
  #--------------------------------------------------------------------------
  def self.item_details_minus_states_font
    f = Font.new()
    f.color = Color.power_down_color()
    f.size = 20
    f.bold = true
    return f
  end
  
  #--------------------------------------------------------------------------
  # * Get Skill Details HP/MP Font
  #--------------------------------------------------------------------------
  def self.skill_details_stats_font
    f = Font.new()
    f.size = 12
    return f
  end
  
  #--------------------------------------------------------------------------
  # * Get Skill Details Plus States Font
  #--------------------------------------------------------------------------
  def self.skill_details_plus_states_font
    f = Font.new()
    f.color = Color.power_up_color()
    f.size = 20
    f.bold = true
    return f
  end
  
  #--------------------------------------------------------------------------
  # * Get Skill Details Minus States Font
  #--------------------------------------------------------------------------
  def self.skill_details_minus_states_font
    f = Font.new()
    f.color = Color.power_down_color()
    f.size = 20
    f.bold = true
    return f
  end
  
end

#==============================================================================
# ** Color
#------------------------------------------------------------------------------
#  Contains the different colors
#==============================================================================

class Color
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get Normal Text Color
  #--------------------------------------------------------------------------
  def self.normal_color
    return text_color(0)
  end
  
  #--------------------------------------------------------------------------
  # * Get Inactive Text Color
  #--------------------------------------------------------------------------
  def self.inactive_color
    return text_color(7)
  end
  
  #--------------------------------------------------------------------------
  # * Get System Text Color
  #--------------------------------------------------------------------------
  def self.system_color
    return text_color(16)
  end
  
  #--------------------------------------------------------------------------
  # * Get Crisis Text Color
  #--------------------------------------------------------------------------
  def self.crisis_color
    return text_color(17)
  end
  
  #--------------------------------------------------------------------------
  # * Get Knockout Text Color
  #--------------------------------------------------------------------------
  def self.knockout_color
    return text_color(18)
  end
  
  #--------------------------------------------------------------------------
  # * Get Gauge Border Color
  #--------------------------------------------------------------------------
  def self.gauge_border_color
    return text_color(0)
  end
  
  #--------------------------------------------------------------------------
  # * Get Gauge Background Color
  #--------------------------------------------------------------------------
  def self.gauge_back_color
    return text_color(19)
  end
  
  #--------------------------------------------------------------------------
  # * Get Inactive Gauge Color 1
  #--------------------------------------------------------------------------
  def self.inactive_gauge_color1
    return text_color(7)
  end
  
  #--------------------------------------------------------------------------
  # * Get Inactive Gauge Color 2
  #--------------------------------------------------------------------------
  def self.inactive_gauge_color2
    return text_color(0)
  end
  
  #--------------------------------------------------------------------------
  # * Get HP Gauge Color 1
  #--------------------------------------------------------------------------
  def self.hp_gauge_color1
    return text_color(20)
  end
  
  #--------------------------------------------------------------------------
  # * Get HP Gauge Color 2
  #--------------------------------------------------------------------------
  def self.hp_gauge_color2
    return text_color(21)
  end
  
  #--------------------------------------------------------------------------
  # * Get MP Gauge Color 1
  #--------------------------------------------------------------------------
  def self.mp_gauge_color1
    return text_color(22)
  end
  
  #--------------------------------------------------------------------------
  # * Get MP Gauge Color 2
  #--------------------------------------------------------------------------
  def self.mp_gauge_color2
    return text_color(23)
  end
  
  #--------------------------------------------------------------------------
  # * Get Equip Screen Power Up Color
  #--------------------------------------------------------------------------
  def self.power_up_color
    return text_color(24)
  end
  
  #--------------------------------------------------------------------------
  # * Get Equip Screen Power Down Color
  #--------------------------------------------------------------------------
  def self.power_down_color
    return text_color(25)
  end
  
  #--------------------------------------------------------------------------
  # * Get Text Color
  #     n : Text color number  (0-31)
  #--------------------------------------------------------------------------
  def self.text_color(n)
    windowskin = Cache.system("Window")
    x = 64 + (n % 8) * 8
    y = 96 + (n / 8) * 8
    return windowskin.get_pixel(x, y)
  end
  
end

#==============================================================================
# ** Bitmap Addon
#------------------------------------------------------------------------------
#  Addon function for drawing lines, circles & polygons
#
#  Based on MACL script
#  Credits to MACL Team (Trickster, SephirothSpawn)
#==============================================================================

class Bitmap
  include EBJB
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the text specified in multiline
  #     rect : rectangle in which the text will be draw
  #     text : text to draw
  #     align : text alignment
  #     multiline_mode = multiline mode (see class description)
  #--------------------------------------------------------------------------
  def draw_multiline_text(rect, text, align=0, multiline_mode=0)
    return if text == nil
    
    lines = split_multiline(rect, text, multiline_mode)
    
    y = rect.y
    line = lines.shift()
    case multiline_mode
    when 0
      # Draw first line normally
      self.draw_text(rect.x, y, rect.width, rect.height, line, align)
      y += rect.height
      text_height = 0
    when 1
      # Draw first line with a specific x and restart to 0 after
      self.draw_text(rect.x, y, rect.width-rect.x, rect.height, line, align)
      y += rect.height
      rect.x = 0
      text_height = 0
    when 2
      # Draw first line with a specific height and restart to text height after
      orig_height = rect.height
      text_height = get_text_height(line)
      if text_height < CORE_CONFIG::LINE_HEIGHT
        text_height = CORE_CONFIG::LINE_HEIGHT
      end
      rect.height = text_height
      self.draw_text(rect.x, y, rect.width, rect.height, line, align)
      y += orig_height
    when 3
      # Mixes mode 1 and 2
      orig_height = rect.height
      text_height = get_text_height(line)
      if text_height < CORE_CONFIG::LINE_HEIGHT
        text_height = CORE_CONFIG::LINE_HEIGHT
      end
      rect.height = text_height
      self.draw_text(rect.x, y, rect.width-rect.x, rect.height, line, align)
      y += orig_height
      rect.x = 0
    else
      # Does nothing
    end
    
#~     if (text_height+(rect.height * lines.size-1)) > self.height - 32
#~       temp_font = self.font.clone
#~       self.dispose
#~       self = Bitmap.new(self.width - 32, text_height+(rect.height * lines.size-1))
#~       self.font = temp_font
#~       self.oy = 0
#~     end
    
    for line in lines
      self.draw_text(rect.x, y, rect.width, rect.height, line, align)
      y += rect.height
    end

  end
  
  #--------------------------------------------------------------------------
  # * Draw the text specified and cutting the overflow
  #     rect : rectangle in which the text will be draw
  #     text : text to draw
  #     align : text alignment
  #--------------------------------------------------------------------------
  def draw_cut_overflow_text(rect, text, align=0)
    return if text == nil
    # built-in draw_text method can reduce the text width up to 60%, so
    # adjust the size to allow the text to be reduced normally before
    # adding the CUT_OVERFLOW_CHARACTER
    length = (get_text_width(text) * 0.5).floor
    
    if (length >= rect.width)
      cutText = format_cut_overflow(rect, text)
    else
      cutText = text
    end
    
    self.draw_text(rect, cutText, align)
  end
  
  #--------------------------------------------------------------------------
  # * Split text in multiline
  #     rect : rectangle in which the text will be drawn
  #     text : text to split
  #     multiline_mode = multiline mode (see class description)
  #--------------------------------------------------------------------------
  def split_multiline(rect, text, multiline_mode=0)
    return [] if text == nil

    case multiline_mode
    when 0
      # Draw first line normally
      x_adjustment = 0
    when 1
      # Draw first line with a specific x and restart to 0 after
      x_adjustment = rect.x
    when 2
      # Draw first line with a specific height and restart to text height after
      x_adjustment = 0
    when 3
      # Mixes mode 1 and 2
      x_adjustment = rect.x
    else
      # Does nothing
    end
    
    textblocks = text.split(CORE_CONFIG::END_LINE_CHARACTER)
    
    lines = []
    for block in textblocks
      length = get_text_width(block)
      
      if (length >= (rect.width-x_adjustment))
        multilineText = format_multiline(rect, block, x_adjustment)
        lines.concat(multilineText.split(CORE_CONFIG::END_LINE_CHARACTER))
      else
        lines.push(block)
      end
    end
    
    return lines
  end
  
  #--------------------------------------------------------------------------
  # * Get the size (width) of the string on the window (with the font)
  #     str : string
  #--------------------------------------------------------------------------
  def get_text_width(str)
    if str != nil
      return self.text_size(str).width
    else
      return 0
    end
  end
  
  #--------------------------------------------------------------------------
  # * Get the size (height) of the string on the window (with the font)
  #     str : string
  #--------------------------------------------------------------------------
  def get_text_height(str)
    if str != nil
      return self.text_size(str).height
    else
      return 0
    end
  end
  
  #-------------------------------------------------------------------------
  # * Draw line (uses the Digital Differential Analyzer Algorithm)
  #     x1 : first line X coordinate
  #     y1 : first line Y coordinate
  #     x2 : second line X coordinate
  #     y2 : second line Y coordinate
  #     c1 : fill color 1 of the line
  #     width : line width
  #     c2 : fill color 2 of the line (used for gradient) 
  #     vertical : true to have a vertical gradient, else false
  #-------------------------------------------------------------------------
  def draw_line(x1, y1, x2, y2, c1, width=1, c2=c1, vertical=false)
    # Return if width is less than or 0
    return if width <= 0
    # Reverse all parameters sent if 2 x is less than the first x
    #x1, x2, y1, y2 = x2, x1, y2, y1 if x2 < x1    
    
    # Get S (1/2 width)
    s = width / 2.0
    gradient = c1 != c2
    
    # If X & Y Coordinates are equal
    if x1 == x2 && y1 == y2
      self.set_pixel(x1, y1, c1)
    # If X Coordinates are equal
    elsif x1 == x2 && y1 != y2
      # Draw Vertical line
      if gradient
        self.gradient_fill_rect(x1 - s, [y1, y2].min, width, (y2 - y1).abs, c1, c2, vertical)
      else
        self.fill_rect(x1 - s, [y1, y2].min, width, (y2 - y1).abs, c1)
      end
    # If Y Coordinates are equal
    elsif y1 == y2 && x1 != x2
      # Draw Horizontal line
      if gradient
        self.gradient_fill_rect([x1, x2].min, y1 - s, (x2 - x1).abs, width, c1, c2, vertical)
      else
        self.fill_rect([x1, x2].min, y1 - s, (x2 - x1).abs, width, c1)
      end
    else
      distance = (x1 - x2).abs + (y1 - y2).abs

      color = c1
      for i in 1..distance
        # Get Percent Distance and I Distance
        per_dist, i_dist = (distance-i)/distance.to_f, i/distance.to_f

        x = (x1 + 1.0 * (x2 - x1) * i_dist).to_i
        y = (y1 + 1.0 * (y2 - y1) * i_dist).to_i

        if gradient
          r = c1.red * per_dist + c2.red * i_dist
          g = c1.green * per_dist + c2.green * i_dist
          b = c1.blue * per_dist + c2.blue * i_dist
          a = c1.alpha * per_dist + c2.alpha * i_dist
          color = Color.new(r, g, b, a)
        end
        
        if width == 1
          self.set_pixel(x-s, y-s, color)
        else
          self.fill_rect(x-s, y-s, width, width, color)
        end
      end
    end
  end
  
  #-------------------------------------------------------------------------
  # * Draw filled circle
  #     x : center of the circle X coordinate
  #     y : center of the circle Y coordinate
  #     radius : radius of the circle
  #     color1 : fill color 1 of the circle
  #     color2 : fill color 2 of the circle (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_filled_circle(x, y, radius, color1, color2=color1)        

    # Starts From Left
    for i in (x - radius)..(x + radius)
      # Finds Distance From Center
      j = (i - x).abs
      # Finds X Position
      x_ = i < x ? x - j : i == x ? x : x + j
      # Finds Top Vertical Portion
      k = Integer((radius ** 2 - j ** 2) ** 0.5)
      # Draws Lines from center
      draw_line(x, y, x_, y-k, color1, 1, color2)
      draw_line(x, y, x_, y+k, color1, 1, color2)
    end
      
    # Switch variables to draw a circle from top
    x = x + y
    y = x - y
    x = x - y
      
    # Starts From Top
    for i in (x - radius)..(x + radius)
      # Finds Distance From Center
      j = (i - x).abs
      # Finds X Position
      x_ = i < x ? x - j : i == x ? x : x + j
      # Finds Top Vertical Portion
      k = Integer((radius ** 2 - j ** 2) ** 0.5)
      # Draws Lines from center
      draw_line(y, x, y-k, x_, color1, 1, color2)
      draw_line(y, x, y+k, x_, color1, 1, color2)
    end
    
  end
  
  #-------------------------------------------------------------------------
  # * Draw circle
  #     x : center of the circle X coordinate
  #     y : center of the circle Y coordinate
  #     radius : radius of the circle
  #     color1 : color 1 of the circle
  #     stroke : size of the stroke of the circle
  #     color2 : color 2 of the circle (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_circle(x, y, radius, color1, stroke=1, color2=color1)        
    # Return if no width
    return if stroke <= 0
    
    rad = radius + stroke
    # Starts From Left
    for i in (x - rad)..(x + rad)
      # Finds Distance From Center
      j = (i - x).abs
      j2 = j - stroke
      # Finds X Position
      x_ = i < x ? x - j : i == x ? x : x + j
      x2_= i < x ? x - j2 : i == x ? x : x + j2
      # Finds Top Vertical Portion
      k = Integer((rad ** 2 - j ** 2) ** 0.5)
      k2 = Integer((radius ** 2 - j2 ** 2) ** 0.5)
      # Draws lines for border
      draw_line(x_, y-k, x2_, y-k2, color1, 1, color2)
      draw_line(x_, y+k, x2_, y+k2, color1, 1, color2)
    end
     
    # Switch variables to draw a circle from top
    x = x + y
    y = x - y
    x = x - y
      
    # Starts From Top
    for i in (x - rad)..(x + rad)
      # Finds Distance From Center
      j = (x - i).abs
      j2 = j - stroke
      # Finds X Position
      x_ = i < x ? x - j : i == x ? x : x + j
      x2_= i < x ? x - j2 : i == x ? x : x + j2
      # Finds Top Vertical Portion
      k = Integer((rad ** 2 - j ** 2) ** 0.5)
      k2 = Integer((radius ** 2 - j2 ** 2) ** 0.5)
      # Draws lines for border
      draw_line(y-k, x_, y-k2, x2_, color1, 1, color2)
      draw_line(y+k, x_, y+k2, x2_, color1, 1, color2)
    end
    
  end
  
  #-------------------------------------------------------------------------
  # * Draw filled polygon
  #     vertices : vertices to draw the polygon
  #     color1 : fill color 1 of the polygon
  #     color2 : fill color 2 of the polygon (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_filled_polygon(vertices, color1, color2=color1)
    # Return if no width or not enough points
    return if vertices.size <= 2
    # Get Count
    count = vertices.size
    # Get Points
    #x1, y1, x2, y2 = vertices[-1] + vertices[0]
    # Draw Line
    #draw_line(x1, y1, x2, y2, stroke, color)
    # Shade if filled
    #cx,cy = vertices[-2]
    #shade_section(cx, cy, x1, y1, x2, y2, stroke, step, color) if filled
    # Run Through with next
    #vertices.each_with_next do |start, point|
    
    cx,cy = vertices[0]
    for i in 1..count-2
      # Get Points
      #x1, y1, x2, y2 = start + point
      x1, y1, x2, y2 = vertices[i] + vertices[i+1]
      # Draw Line
      #draw_line(x1, y1, x2, y2, stroke, color)
      # Shade if filled
      shade_section(cx, cy, x1, y1, x2, y2, color1, 1, color2)
    end
  end
  
  #-------------------------------------------------------------------------
  # * Draw polygon
  #     vertices : vertices to draw the polygon
  #     color1 : fill color 1 of the polygon
  #     stroke : size of the stroke of the polygon
  #     color2 : fill color 2 of the polygon (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_polygon(vertices, color1, stroke=1, color2=color1)
    # Return if no width or not enough points
    return if stroke <= 0 || vertices.size <= 2
    # Get Count
    count = vertices.size

    for i in 0..count-1
      # Get Points
      #x1, y1, x2, y2 = start + point
      x1, y1, x2, y2 = vertices[i-1] + vertices[i]
      # Draw Line
      draw_line(x1, y1, x2, y2, color1, stroke, color2)
    end
  end
  
  #-------------------------------------------------------------------------
  # * Draw filled ellipse
  #     x : center of the circle X coordinate
  #     y : center of the circle Y coordinate
  #     a : distance from center to right side
  #     b : distance from center to top side
  #     color1 : fill color 1 of the circle
  #     color2 : fill color 2 of the circle (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_filled_ellipse(x, y, a, b, color1, color2=color1)
    # Converts Each Argument to Float
    x, y, a, b = x.to_f, y.to_f, a.to_f, b.to_f
    # Gets Square of a and b values
    a2, b2 = a * a, b * b

    # Pass from center to right side
    for i in 0..b
      # Gets X Distance
      x_ = Integer(Math.sqrt(a2 * (1 - i ** 2 / b2)))
      # Draws Lines on Top & Bottom
      draw_line(x, y, x-x_, y-i, color1, 1, color2)
      draw_line(x, y, x-x_, y+i, color1, 1, color2)
      draw_line(x, y, x+x_, y-i, color1, 1, color2)
      draw_line(x, y, x+x_, y+i, color1, 1, color2)
    end
    # Pass from center to right side
    for i in 0..a
      # Gets Y Distance
      y_ = Integer(Math.sqrt(b2 * (1 - (i ** 2) / a2)))
      # Draws Lines on Each Side
      draw_line(x, y, x-i, y-y_, color1, 1, color2, true)
      draw_line(x, y, x+i, y-y_, color1, 1, color2, true)
      draw_line(x, y, x-i, y+y_, color1, 1, color2, true)
      draw_line(x, y, x+i, y+y_, color1, 1, color2, true)
    end

  end
    
  #-------------------------------------------------------------------------
  # * Draw ellipse
  #     x : center of the circle X coordinate
  #     y : center of the circle Y coordinate
  #     a : the distance from center to right side
  #     b : the distance from center to top side
  #     color1 : fill color 1 of the circle
  #     stroke : size of the stroke of the ellipse
  #     color2 : fill color 2 of the circle (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_ellipse(x, y, a, b, color1, stroke=1, color2=color1)
    # Return if no width
    return if stroke <= 0
    
    # Converts Each Argument to Float
    x, y, a, b = x.to_f, y.to_f, a.to_f, b.to_f
    # Gets Square of a and b values
    a2, b2 = a * a, b * b
    # Gets Square of a and b values
    a2_2, b2_2 = (a+stroke) * (a+stroke), (b+stroke) * (b+stroke)
    
    # Pass from center to right side
    for i in 0..b
      # Gets X Distance
      x_ = Integer(Math.sqrt(a2 * (1 - i ** 2 / b2)))
      x2_ = Integer(Math.sqrt(a2_2 * (1 - i ** 2 / b2_2)))
      
      # Draws Lines on Top & Bottom
      draw_line(x-x2_, y-i, x-x_, y-i, color1, 1, color2)
      draw_line(x-x2_, y+i, x-x_, y+i, color1, 1, color2)
      draw_line(x+x2_, y-i, x+x_, y-i, color2, 1, color1)
      draw_line(x+x2_, y+i, x+x_, y+i, color2, 1, color1)
    end
    # Pass from center to right side
    for i in 0..a
      # Gets Y Distance
      y_ = Integer(Math.sqrt(b2 * (1 - (i ** 2) / a2)))
      y2_ = Integer(Math.sqrt(b2_2 * (1 - (i ** 2) / a2_2)))
      
      # Draws Lines on Each Side
      draw_line(x-i, y-y2_, x-i, y-y_, color1, 1, color2, true)
      draw_line(x+i, y-y2_, x+i, y-y_, color1, 1, color2, true)
      draw_line(x-i, y+y_, x-i, y+y2_, color2, 1, color1, true)
      draw_line(x+i, y+y_, x+i, y+y2_, color2, 1, color1, true)
    end

  end
  
  #-------------------------------------------------------------------------
  # * Shade section
  #     ox : origin section X coordinate
  #     oy : origin section Y coordinate
  #     x1 : first section X coordinate
  #     y1 : first section Y coordinate
  #     x2 : second section X coordinate
  #     y2 : second section Y coordinate
  #     c1 : fill color 1 of the section
  #     thick : line thickness
  #     c2 : fill color 2 of the section (used for gradient) 
  #-------------------------------------------------------------------------
  def shade_section(ox, oy, x1, y1, x2, y2, c1, thick=1, c2=c1)
    # Reverse all parameters sent if 2 x is less than the first x
    #x1, x2, y1, y2 = x2, x1, y2, y1 if x2 < x1    
    # Get Slope
    #slope = (y2 - y1).to_f / (x2 - x1)
    # If Slope is infinite
    #if slope.infinite?
    #  y1.step(y2, step) {|y| draw_line(cx, cy, x1, y, thick, color)}
    # If Slope is zero
    #elsif slope.zero?
    #  x1.step(x2, step) {|x| draw_line(cx, cy, x, y1, thick, color)}
    #elsif not slope.nan?
      # Get Y intercept
    #  yint = y1 - slope * x1
    #  x1.step(x2, step) {|x| draw_line(cx, cy, x, slope * x + yint, thick, color)}
    #end
    
    temp_x1 = x1
    temp_y1 = y1
    distance = (x1 - x2).abs + (y1 - y2).abs
    i = 1
    while temp_x1 != x2 || temp_y1 != y2
      draw_line(ox, oy, temp_x1, temp_y1, c1, thick, c2)
      temp_x1 = (x1 + 1.0 * (x2 - x1) * i / distance).to_i
      temp_y1 = (y1 + 1.0 * (y2 - y1) * i / distance).to_i
      i += 1
    end
  end
  
  #-------------------------------------------------------------------------
  # * Saves Bitmap to a PNG file memory stream
  #     bitmap : Bitmap object to save
  #     path : directory in Game folder
  #     mode : mode of writing
  #-------------------------------------------------------------------------
  def self.make_png(bitmap, path = '', mode = 0)
    Dir.make_dir(path) if path != ''
    Zlib::Png_File.open('temp.gz')   { |gz| gz.make_png(bitmap, mode) }
    Zlib::GzipReader.open('temp.gz') { |gz| $read = gz.read }
    # Add this to create a file
    #f = File.open(path + name + '.png', 'wb')
    #f.write($read)
    #f.close
    File.delete('temp.gz')
    return $read
  end
  
  #-------------------------------------------------------------------------
  # * Reads PNG to Bitmap
  #     temp_gz : stream of the PNG File
  #     path : directory in Game folder
  #-------------------------------------------------------------------------
  def self.read_png(temp_gz, path = '')
    Dir.make_dir(path) if path != ''
    f = File.open(path + 'temp.png', 'wb')
    f.write(temp_gz)
    f.close
    bitmap = Bitmap.new(path + 'temp.png')
    File.delete('temp.png')
    return bitmap
  end
  
  #--------------------------------------------------------------------------
  # * Update bitmap size
  #     width : new width
  #     height : new height
  #--------------------------------------------------------------------------
  def self.update_bitmap_size(bitmap, width, height)
    temp_font = bitmap.font.clone
    bitmap.dispose
    bitmap = Bitmap.new(width, height)
    bitmap.font = temp_font
    return bitmap
    #self.oy = 0
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
    
  #--------------------------------------------------------------------------
  # * Format text in multiline
  #     rect : rectangle in which the text will be drawn
  #     text : text to draw
  #     x_adjustment = X coordinate adjustment depending on multiline mode (see class description)
  #--------------------------------------------------------------------------
  def format_multiline(rect, text, x_adjustment=0)
    if (text == "")
      return text
    end
    
    text = text.lstrip
    subtext = ""
    size = get_text_width(text) + get_text_width(CORE_CONFIG::LINE_SEPARATOR) * 2
    while (size > (rect.width-x_adjustment) && text.length > 0)
      char = text[text.length-1, text.length]
      size -= get_text_width(char)
      subtext += char
      text = text.chop
    end
    subtext = subtext.reverse

    if ((text[text.length-1,text.length] != " ") && (subtext[0,1] != " ") &&
        (subtext[0,1] != ""))
      text += CORE_CONFIG::LINE_SEPARATOR
    end
    
    return text + CORE_CONFIG::END_LINE_CHARACTER + format_multiline(rect, subtext)
  end
  private :format_multiline
  
  #--------------------------------------------------------------------------
  # * Format text to cut the overflow
  #     rect : rectangle in which the text will be drawn
  #     text : text to draw
  #--------------------------------------------------------------------------
  def format_cut_overflow(rect, text)
    if (text == "")
      return text
    end
    
    text = text.strip
    size = get_text_width(text) + get_text_width(CORE_CONFIG::CUT_OVERFLOW_CHARACTER) * 2
    # built-in draw_text method can reduce the text width up to 60%, so
    # adjust the size to allow the text to be reduced normally before
    # adding the CUT_OVERFLOW_CHARACTER
    size = (size * 0.5).floor
    while (size > rect.width)
      char = text[text.length-1, text.length]
      size -= (get_text_width(char) * 0.5).floor
      text = text.chop
    end
    
    return text + CORE_CONFIG::CUT_OVERFLOW_CHARACTER
  end
  private :format_cut_overflow

end

#==============================================================================
# ** Vocab
#------------------------------------------------------------------------------
#  This module defines terms and messages. It defines some data as constant
# variables. Terms in the database are obtained from $data_system.
#==============================================================================

module Vocab

  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #//////////////////////////////////////////////////////////////////////////
  # * Stats Parameters related
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get HP Label
  #--------------------------------------------------------------------------
  def self.hp_label
    return self.hp
  end
  
  #--------------------------------------------------------------------------
  # * Get MP Label
  #--------------------------------------------------------------------------
  def self.mp_label
    return self.mp
  end
  
  #--------------------------------------------------------------------------
  # * Get ATK Label
  #--------------------------------------------------------------------------
  def self.atk_label
    return self.atk
  end
  
  #--------------------------------------------------------------------------
  # * Get DEF Label
  #--------------------------------------------------------------------------
  def self.def_label
    return self.def
  end
  
  #--------------------------------------------------------------------------
  # * Get SPI Label
  #--------------------------------------------------------------------------
  def self.spi_label
    return self.spi
  end
  
  #--------------------------------------------------------------------------
  # * Get AGI Label
  #--------------------------------------------------------------------------
  def self.agi_label
    return self.agi
  end
  
  #--------------------------------------------------------------------------
  # * Get EVA Label
  #--------------------------------------------------------------------------
  def self.eva_label
    return "EVA"
  end
  
  #--------------------------------------------------------------------------
  # * Get HIT Label
  #--------------------------------------------------------------------------
  def self.hit_label
    return "HIT"
  end
  
  #--------------------------------------------------------------------------
  # * Get CRI Label
  #--------------------------------------------------------------------------
  def self.cri_label
    return "CRI"
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Details Window related
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get Label to show for the Elements list
  #--------------------------------------------------------------------------
  def self.elements_label
    return "ELEMENTS"
  end
  
  #--------------------------------------------------------------------------
  # * Get Label to show for the States list
  #--------------------------------------------------------------------------
  def self.states_label
    return "STATES"
  end
  
  #--------------------------------------------------------------------------
  # * Get Label to show for the Stats
  #--------------------------------------------------------------------------
  def self.stats_label
    return "STATS"
  end
  
  #--------------------------------------------------------------------------
  # * Get Label to show for the Recovery effect
  #--------------------------------------------------------------------------
  def self.recovery_label
    return "RECOVERY"
  end
  
  #--------------------------------------------------------------------------
  # * Get Label to show for the Damage effect
  #--------------------------------------------------------------------------
  def self.damage_label
    return "DAMAGE"
  end
  
  #--------------------------------------------------------------------------
  # * Get Label to show for the Scope list
  #--------------------------------------------------------------------------
  def self.scopes_label
    return "DAMAGE"
  end
  
  #--------------------------------------------------------------------------
  # * Get Label to show for the Bonus list
  #--------------------------------------------------------------------------
  def self.bonus_label
    return "BONUS"
  end
  
end

#==============================================================================
# ** GraphElement
#------------------------------------------------------------------------------
#  Represents a GraphElement object for the UCGraph control
#==============================================================================

class GraphElement
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Icon index
  attr_accessor :iconIndex
  # Current value of the element
  attr_accessor :value
    
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     iconIndex : icon index
  #     value : current value
  #--------------------------------------------------------------------------
  def initialize(iconIndex, value)
    self.iconIndex = iconIndex
    self.value = value
  end
  
end

#==============================================================================
# ** CursorPosition
#------------------------------------------------------------------------------
#  Represents a CursorPosition object for the Window_Custom_Selectable window
#==============================================================================

class CursorPosition
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Rectangle of the cursor position
  attr_accessor :rect
  # True if the position is enabled, else false
  attr_accessor :enabled
    
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     rect : rectangle of the cursor position
  #     enabled : true if the position is enabled, else false
  #--------------------------------------------------------------------------
  def initialize(rect, enabled=true)
    self.rect = rect
    self.enabled = enabled
  end
  
end

#==============================================================================
# ** Filter
#------------------------------------------------------------------------------
#  Represents a filter
#==============================================================================

class Filter
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Filter mode (values are defined by the subclasses)
  attr_reader :mode
  # Value used to filter
  attr_reader :value
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     mode : filter mode (values are defined by the subclasses)
  #     value : value used to filter
  #--------------------------------------------------------------------------
  def initialize(mode=nil, value=nil)
    @mode = mode
    @value = value
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method (contents are defined by the subclasses)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def apply(x)
  end
  
end

#==============================================================================
# ** Comparer
#------------------------------------------------------------------------------
#  Represents a comparer
#==============================================================================

class Comparer
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Compare mode (values are defined by the subclasses)
  attr_reader :mode
  # Compare order
  #   0 - Asc
  #   1 - Desc
  attr_reader :order
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     mode : compare mode (values are defined by the subclasses)
  #     order : compare order (see Attributes section)
  #--------------------------------------------------------------------------
  def initialize(mode=nil, order=0)
    @mode = mode
    @order = order
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Compare method (contents are defined by the subclasses)
  #     x : first object to compare
  #     y : second object to compare
  #--------------------------------------------------------------------------
  def compare(x,y)
  end
  
end

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

#==============================================================================
# ** BaseItemFilter
#------------------------------------------------------------------------------
#  Represents a BaseItem filter
#==============================================================================

class BaseItemFilter < Filter
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method
  #     x : object to filter
  #--------------------------------------------------------------------------
  def apply(x)
    if x != nil && x.is_a?(RPG::BaseItem)
       
      case mode
        when "name"
          return applyName(x)
        #when
          #...
        else
          return true
      end
      
    else
      return nil
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method (using the name property)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applyName(x)
    if x.name == @value
      return true
    else
      return false
    end
  end
  private:applyName
  
end

#==============================================================================
# ** UsableItemFilter
#------------------------------------------------------------------------------
#  Represents an UsableItem filter
#==============================================================================

class UsableItemFilter < BaseItemFilter
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method
  #     x : object to filter
  #--------------------------------------------------------------------------
  alias apply_baseUsableItemFilter_ebjb apply unless $@
  def apply(x)
    if x != nil && x.is_a?(RPG::UsableItem)
       
      case mode
        when "physical_attack"
          return applyPhysicalAttack(x)
        #when
          #...
        else
          return apply_baseUsableItemFilter_ebjb(x)
      end
      
    else
      return nil
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method (using the physical_attack property)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applyPhysicalAttack(x)
    if x.physical_attack == @value
      return true
    else
      return false
    end
  end
  private:applyPhysicalAttack
  
end

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

#==============================================================================
# ** WeaponFilter
#------------------------------------------------------------------------------
#  Represents a Weapon filter
#==============================================================================

class WeaponFilter < BaseItemFilter
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method
  #     x : object to filter
  #--------------------------------------------------------------------------
  alias apply_baseWeaponFilter_ebjb apply unless $@  
  def apply(x)
    if x != nil && x.is_a?(RPG::Weapon)
       
      case mode
        when "two_handed"
          return applyTwoHanded(x)
        #when
          #...
        else
          return apply_baseWeaponFilter_ebjb(x)
      end
      
    else
      return nil
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Apply method (using the two_handed property)
  #     x : object to filter
  #--------------------------------------------------------------------------
  def applyTwoHanded(x)
    if x.two_handed == @value
      return true
    else
      return false
    end
  end
  private:applyTwoHanded
  
end

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

#==============================================================================
# ** Require Definition
#------------------------------------------------------------------------------
#  Definition of the require function to use other Ruby libraries
#==============================================================================

@@required_files = []
$: ||= ["./"]

def require(filename)
  if File.extname(filename) == "" then
    filename = filename + ".rb"
  end
  if @@required_files.include?(filename) then
    return false
  else
    @@required_files << filename
    file = $:.dup.find {|path|
      if path[-1,1] != "/" then path << "/" end
      File.exist?(path+filename)
    }
    if file then File.open(file+filename, "r") {|f| eval(f.read)} else raise LoadError end
    return true
  end
end

