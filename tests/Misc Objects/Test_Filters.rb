#==============================================================================
# ** Test_Filters
#------------------------------------------------------------------------------
#  Unit tests for the filters
#==============================================================================

class Test_Filters < Test_Class

  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Setup tests
  #--------------------------------------------------------------------------
  def testFixtureSetup()
    @baseItems = []
    for i in 0...$data_items.size
      @baseItems.push($data_items[i])
    end
    for i in 0...$data_weapons.size
      @baseItems.push($data_weapons[i])
    end
    for i in 0...$data_armors.size
      @baseItems.push($data_armors[i])
    end
    @baseItems.compact!
    
    @usableItems = []
    for i in 0...$data_items.size
      @usableItems.push($data_items[i])
    end
    for i in 0...$data_skills.size
      @usableItems.push($data_skills[i])
    end
    @usableItems.compact!
  end
  
  #--------------------------------------------------------------------------
  # * Tear down tests
  #--------------------------------------------------------------------------
  def testFixtureTearDown()
    @baseItems.clear()
    @baseItems = nil
    @usableItems.clear()
    @usableItems = nil
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Tests
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * BaseItemFilter by default
  #--------------------------------------------------------------------------
  def test_defaultBaseItem
    f = BaseItemFilter.new()
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == @baseItems.size
  end
  
  #--------------------------------------------------------------------------
  # * BaseItemFilter with empty list
  #--------------------------------------------------------------------------
  def test_emptyBaseItem
    f = BaseItemFilter.new()
    new_list = [].find_all{|x| f.apply(x)}
    return new_list.size == 0
  end

  #--------------------------------------------------------------------------
  # * BaseItemFilter with name mode with null value
  #--------------------------------------------------------------------------
  def test_nameBaseItemNullValue
    f = BaseItemFilter.new("name")
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * BaseItemFilter with name mode
  #--------------------------------------------------------------------------
  def test_nameBaseItem
    f = BaseItemFilter.new("name", "Potion")
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == 1
  end
  
  #--------------------------------------------------------------------------
  # * UsableItemFilter by default
  #--------------------------------------------------------------------------
  def test_defaultUsableItem
    f = UsableItemFilter.new()
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == @usableItems.size
  end
  
  #--------------------------------------------------------------------------
  # * UsableItemFilter with empty list
  #--------------------------------------------------------------------------
  def test_emptyUsableItem
    f = UsableItemFilter.new()
    new_list = [].find_all{|x| f.apply(x)}
    return new_list.size == 0
  end

  #--------------------------------------------------------------------------
  # * UsableItemFilter with name mode with null value
  #--------------------------------------------------------------------------
  def test_nameUsableItemNullValue
    f = UsableItemFilter.new("name")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * UsableItemFilter with name mode
  #--------------------------------------------------------------------------
  def test_nameUsableItem
    f = UsableItemFilter.new("name", "Potion")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 1
  end
  
  #--------------------------------------------------------------------------
  # * UsableItemFilter with physical_attack mode with null value
  #--------------------------------------------------------------------------
  def test_physicalAttackUsableItemNullValue
    f = UsableItemFilter.new("physical_attack")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * UsableItemFilter with physical_attack mode
  #--------------------------------------------------------------------------
  def test_physicalAttackUsableItem
    f = UsableItemFilter.new("physical_attack", true)
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 12
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter by default
  #--------------------------------------------------------------------------
  def test_defaultItem
    f = ItemFilter.new()
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == $data_items.compact.size
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with empty list
  #--------------------------------------------------------------------------
  def test_emptyItem
    f = ItemFilter.new()
    new_list = [].find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with name mode with null value
  #--------------------------------------------------------------------------
  def test_nameItemNullValue
    f = ItemFilter.new("name")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with name mode
  #--------------------------------------------------------------------------
  def test_nameItem
    f = ItemFilter.new("name", "Potion")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 1
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with physical_attack mode with null value
  #--------------------------------------------------------------------------
  def test_physicalAttackItemNullValue
    f = ItemFilter.new("physical_attack")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with physical_attack mode
  #--------------------------------------------------------------------------
  def test_physicalAttackItem
    f = ItemFilter.new("physical_attack", true)
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 2
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with healing mode with null value
  #--------------------------------------------------------------------------
  def test_healingItemNullValue
    f = ItemFilter.new("healing")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with healing mode
  #--------------------------------------------------------------------------
  def test_healingItem
    f = ItemFilter.new("healing", true)
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 6
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with support mode with null value
  #--------------------------------------------------------------------------
  def test_supportItemNullValue
    f = ItemFilter.new("support")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with support mode
  #--------------------------------------------------------------------------
  def test_supportItem
    f = ItemFilter.new("support", true)
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 3
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with growth mode with null value
  #--------------------------------------------------------------------------
  def test_growthItemNullValue
    f = ItemFilter.new("growth")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with growth mode
  #--------------------------------------------------------------------------
  def test_growthItem
    f = ItemFilter.new("growth", true)
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 6
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with attack mode with null value
  #--------------------------------------------------------------------------
  def test_attackItemNullValue
    f = ItemFilter.new("attack")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * ItemFilter with attack mode
  #--------------------------------------------------------------------------
  def test_attackItem
    f = ItemFilter.new("attack", true)
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 9
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter by default
  #--------------------------------------------------------------------------
  def test_defaultSkill
    f = SkillFilter.new()
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == $data_skills.compact.size
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter with empty list
  #--------------------------------------------------------------------------
  def test_emptySkill
    f = SkillFilter.new()
    new_list = [].find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter with name mode with null value
  #--------------------------------------------------------------------------
  def test_nameSkillNullValue
    f = SkillFilter.new("name")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter with name mode
  #--------------------------------------------------------------------------
  def test_nameSkill
    f = SkillFilter.new("name", "Fire")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 1
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter with physical_attack mode with null value
  #--------------------------------------------------------------------------
  def test_physicalAttackSkillNullValue
    f = SkillFilter.new("physical_attack")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter with physical_attack mode
  #--------------------------------------------------------------------------
  def test_physicalAttackSkill
    f = SkillFilter.new("physical_attack", true)
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 10
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter with healing mode with null value
  #--------------------------------------------------------------------------
  def test_healingSkillNullValue
    f = SkillFilter.new("healing")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter with healing mode
  #--------------------------------------------------------------------------
  def test_healingSkill
    f = SkillFilter.new("healing", true)
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 11
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter with support mode with null value
  #--------------------------------------------------------------------------
  def test_supportSkillNullValue
    f = SkillFilter.new("support")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter with support mode
  #--------------------------------------------------------------------------
  def test_supportSkill
    f = SkillFilter.new("support", true)
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 29
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter with attack mode with null value
  #--------------------------------------------------------------------------
  def test_attackSkillNullValue
    f = SkillFilter.new("attack")
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * SkillFilter with attack mode
  #--------------------------------------------------------------------------
  def test_attackSkill
    f = SkillFilter.new("attack", true)
    new_list = @usableItems.find_all{|x| f.apply(x)}
    return new_list.size == 44
  end
  
  #--------------------------------------------------------------------------
  # * WeaponFilter by default
  #--------------------------------------------------------------------------
  def test_defaultWeapon
    f = WeaponFilter.new()
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == $data_weapons.compact.size
  end
  
  #--------------------------------------------------------------------------
  # * WeaponFilter with empty list
  #--------------------------------------------------------------------------
  def test_emptyWeapon
    f = WeaponFilter.new()
    new_list = [].find_all{|x| f.apply(x)}
    return new_list.size == 0
  end

  #--------------------------------------------------------------------------
  # * WeaponFilter with name mode with null value
  #--------------------------------------------------------------------------
  def test_nameWeaponNullValue
    f = WeaponFilter.new("name")
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * WeaponFilter with name mode
  #--------------------------------------------------------------------------
  def test_nameWeapon
    f = WeaponFilter.new("name", "Club")
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == 1
  end
  
  #--------------------------------------------------------------------------
  # * WeaponFilter with two_handed mode with null value
  #--------------------------------------------------------------------------
  def test_twoHandedWeaponNullValue
    f = WeaponFilter.new("two_handed")
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * WeaponFilter with two_handed mode
  #--------------------------------------------------------------------------
  def test_twoHandedWeapon
    f = WeaponFilter.new("two_handed", true)
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == 16
  end
  
  #--------------------------------------------------------------------------
  # * ArmorFilter by default
  #--------------------------------------------------------------------------
  def test_defaultArmor
    f = ArmorFilter.new()
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == $data_armors.compact.size
  end
  
  #--------------------------------------------------------------------------
  # * ArmorFilter with empty list
  #--------------------------------------------------------------------------
  def test_emptyArmor
    f = ArmorFilter.new()
    new_list = [].find_all{|x| f.apply(x)}
    return new_list.size == 0
  end

  #--------------------------------------------------------------------------
  # * ArmorFilter with name mode with null value
  #--------------------------------------------------------------------------
  def test_nameArmorNullValue
    f = ArmorFilter.new("name")
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * ArmorFilter with name mode
  #--------------------------------------------------------------------------
  def test_nameArmor
    f = ArmorFilter.new("name", "Leather Shield")
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == 1
  end
  
  #--------------------------------------------------------------------------
  # * ArmorFilter with kind mode with null value
  #--------------------------------------------------------------------------
  def test_kindArmorNullValue
    f = ArmorFilter.new("kind")
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * ArmorFilter with kind mode
  #--------------------------------------------------------------------------
  def test_kindArmor
    f = ArmorFilter.new("kind", 2)
    new_list = @baseItems.find_all{|x| f.apply(x)}
    return new_list.size == 11
  end
  
end
