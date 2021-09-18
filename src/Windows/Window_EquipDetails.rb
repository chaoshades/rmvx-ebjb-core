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
