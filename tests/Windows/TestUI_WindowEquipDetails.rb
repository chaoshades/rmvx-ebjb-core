#==============================================================================
# ** TestUI_WindowEquipDetails
#------------------------------------------------------------------------------
#  Unit tests for the window equip details
#==============================================================================

class TestUI_WindowEquipDetails < TestUI_Class
  
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
  # * Window_EquipDetails by default
  #--------------------------------------------------------------------------
  def test_default
    w = Window_EquipDetails.new(0,0,640,96,nil)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_EquipDetails with simple weapon
  #--------------------------------------------------------------------------
  def test_simpleWeapon
    w = Window_EquipDetails.new(0,96,640,96,$data_weapons[1])
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_EquipDetails with simple armor
  #--------------------------------------------------------------------------
  def test_simpleArmor
    w = Window_EquipDetails.new(0,192,640,96,$data_armors[1])
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_EquipDetails with full weapon
  #--------------------------------------------------------------------------
  def test_fullWeapon
    w = Window_EquipDetails.new(0,288,640,96,$data_weapons[31])
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_EquipDetails with full armor
  #--------------------------------------------------------------------------
  def test_fullArmor
    w = Window_EquipDetails.new(0,384,640,96,$data_armors[31])
    @windows.push(w)
    return true
  end
  
end
