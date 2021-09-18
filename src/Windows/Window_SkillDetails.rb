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
