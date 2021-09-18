#==============================================================================
# ** Test_Comparers
#------------------------------------------------------------------------------
#  Unit tests for the comparers
#==============================================================================

class Test_Comparers < Test_Class

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
    
    @skills = []
    for i in 0...$data_skills.size
      @skills.push($data_skills[i])
    end
    @skills.compact!
    
    @items = []
    for i in 0...$data_items.size
      @items.push($data_items[i])
    end
    @items.compact!
  end
  
  #--------------------------------------------------------------------------
  # * Tear down tests
  #--------------------------------------------------------------------------
  def testFixtureTearDown()
    @baseItems.clear()
    @baseItems = nil
    @skills.clear()
    @skills = nil
    @items.clear()
    @items = nil
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Tests
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * BaseItemComparer by default
  #--------------------------------------------------------------------------
  def test_defaultBaseItem
    c = BaseItemComparer.new()
    first = @baseItems[0].id
    second = @baseItems[1].id
    third = @baseItems[2].id
    new_list = @baseItems.sort{|x,y| c.compare(x,y)}
    return new_list[0].id == first &&
           new_list[1].id == second &&
           new_list[2].id == third
  end
  
  #--------------------------------------------------------------------------
  # * BaseItemComparer with empty list
  #--------------------------------------------------------------------------
  def test_emptyBaseItem
    c = BaseItemComparer.new()
    new_list = [].sort{|x,y| c.compare(x,y)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * BaseItemComparer with name mode (asc by default)
  #--------------------------------------------------------------------------
  def test_nameBaseItem
    c = BaseItemComparer.new("name")
    new_list = @baseItems.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Antidote" &&
           new_list[1].name == "Bastard Sword" &&
           new_list[2].name == "Battle Axe"
  end
         
  #--------------------------------------------------------------------------
  # * BaseItemComparer with name mode (desc)
  #--------------------------------------------------------------------------
  def test_nameBaseItemDesc
    c = BaseItemComparer.new("name", 1)
    new_list = @baseItems.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Wrapped Bow" &&
           new_list[1].name == "Wizard Rod" &&
           new_list[2].name == "Warrior Bracelet"
  end
         
  #--------------------------------------------------------------------------
  # * BaseItemComparer with type mode (asc by default)
  #--------------------------------------------------------------------------
  def test_typeBaseItem
    c = BaseItemComparer.new("type")
    new_list = @baseItems.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Potion" &&
           new_list[1].name == "High potion" &&
           new_list[2].name == "Full potion"
  end
         
  #--------------------------------------------------------------------------
  # * BaseItemComparer with type mode (desc)
  #--------------------------------------------------------------------------
  def test_typeBaseItemDesc
    c = BaseItemComparer.new("type", 1)
    new_list = @baseItems.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Ultima Mail" &&
           new_list[1].name == "Sage's ring" &&
           new_list[2].name == "Life Ring"
  end
  
  #--------------------------------------------------------------------------
  # * SkillComparer by default
  #--------------------------------------------------------------------------
  def test_defaultSkill
    c = SkillComparer.new()
    first = @skills[0].id
    second = @skills[1].id
    third = @skills[2].id
    new_list = @skills.sort{|x,y| c.compare(x,y)}
    return new_list[0].id == first &&
           new_list[1].id == second &&
           new_list[2].id == third
  end
  
  #--------------------------------------------------------------------------
  # * SkillComparer with empty list
  #--------------------------------------------------------------------------
  def test_emptySkill
    c = SkillComparer.new()
    new_list = [].sort{|x,y| c.compare(x,y)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * SkillComparer with name mode (asc by default)
  #--------------------------------------------------------------------------
  def test_nameSkill
    c = SkillComparer.new("name")
    new_list = @skills.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Armor Bless" &&
           new_list[1].name == "Armor Curse" &&
           new_list[2].name == "Blind"
  end
         
  #--------------------------------------------------------------------------
  # * SkillComparer with name mode (desc)
  #--------------------------------------------------------------------------
  def test_nameSkillDesc
    c = SkillComparer.new("name", 1)
    new_list = @skills.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Wind" &&
           new_list[1].name == "Weapon Curse" &&
           new_list[2].name == "Weapon Bless"
  end
  
  #--------------------------------------------------------------------------
  # * SkillComparer with mp_cost mode (asc by default)
  #--------------------------------------------------------------------------
  def test_mpCostSkill
    c = SkillComparer.new("mp_cost")
    new_list = @skills.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Dual Attack" &&
           new_list[1].name == "Double Attack" &&
           new_list[2].name == "Triple Attack"
  end
         
  #--------------------------------------------------------------------------
  # * SkillComparer with mp_cost mode (desc)
  #--------------------------------------------------------------------------
  def test_mpCostSkillDesc
    c = SkillComparer.new("mp_cost", 1)
    new_list = @skills.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Ultima" &&
           new_list[1].name == "Newclear" &&
           new_list[2].name == "Darkness"
  end
  
  #--------------------------------------------------------------------------
  # * ItemComparer by default
  #--------------------------------------------------------------------------
  def test_defaultItem
    c = ItemComparer.new()
    first = @skills[0].id
    second = @skills[1].id
    third = @skills[2].id
    new_list = @items.sort{|x,y| c.compare(x,y)}
    return new_list[0].id == first &&
           new_list[1].id == second &&
           new_list[2].id == third
  end
  
  #--------------------------------------------------------------------------
  # * ItemComparer with empty list
  #--------------------------------------------------------------------------
  def test_emptyItem
    c = ItemComparer.new()
    new_list = [].sort{|x,y| c.compare(x,y)}
    return new_list.size == 0
  end
  
  #--------------------------------------------------------------------------
  # * ItemComparer with name mode (asc by default)
  #--------------------------------------------------------------------------
  def test_nameItem
    c = ItemComparer.new("name")
    new_list = @items.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Antidote" &&
           new_list[1].name == "Blizzard scroll" &&
           new_list[2].name == "Dispel herb"
  end
         
  #--------------------------------------------------------------------------
  # * ItemComparer with name mode (desc)
  #--------------------------------------------------------------------------
  def test_nameItemDesc
    c = ItemComparer.new("name", 1)
    new_list = @items.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Ultima scroll" &&
           new_list[1].name == "Thunder scroll" &&
           new_list[2].name == "Swords scroll"
  end
         
  #--------------------------------------------------------------------------
  # * ItemComparer with price mode (asc by default)
  #--------------------------------------------------------------------------
  def test_priceItem
    c = ItemComparer.new("price")
    new_list = @items.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Antidote" &&
           new_list[1].name == "Potion" &&
           new_list[2].name == "Dispel herb"
  end
         
  #--------------------------------------------------------------------------
  # * ItemComparer with price mode (desc)
  #--------------------------------------------------------------------------
  def test_priceItemDesc
    c = ItemComparer.new("price", 1)
    new_list = @items.sort{|x,y| c.compare(x,y)}
    return new_list[0].name == "Ultima scroll" &&
           new_list[1].name == "Full Elixir" &&
           new_list[2].name == "Elixir"
  end
  
end
