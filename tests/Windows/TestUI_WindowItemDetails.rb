#==============================================================================
# ** TestUI_WindowItemDetails
#------------------------------------------------------------------------------
#  Unit tests for the window item details
#==============================================================================

class TestUI_WindowItemDetails < TestUI_Class
  
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
  # * Window_ItemDetails by default
  #--------------------------------------------------------------------------
  def test_default
    w = Window_ItemDetails.new(0,0,640,96,nil)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_ItemDetails with simple recovery item
  #--------------------------------------------------------------------------
  def test_simpleRecoveryItem
    w = Window_ItemDetails.new(0,96,640,96,$data_items[1])
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_ItemDetails with simple damage item
  #--------------------------------------------------------------------------
  def test_simpleDamageItem
    w = Window_ItemDetails.new(0,192,640,96,$data_items[16])
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_ItemDetails with full recovery item
  #--------------------------------------------------------------------------
  def test_fullRecoveryItem
    w = Window_ItemDetails.new(0,288,640,96,$data_items[23])
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_ItemDetails with full damage item
  #--------------------------------------------------------------------------
  def test_fullDamageItem
    w = Window_ItemDetails.new(0,384,640,96,$data_items[24])
    @windows.push(w)
    return true
  end
  
end
