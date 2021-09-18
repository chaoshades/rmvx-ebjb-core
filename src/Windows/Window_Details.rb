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
