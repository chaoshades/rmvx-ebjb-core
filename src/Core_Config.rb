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
