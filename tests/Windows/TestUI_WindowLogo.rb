#==============================================================================
# ** TestUI_WindowLogo
#------------------------------------------------------------------------------
#  Unit tests for the window logo
#==============================================================================

class TestUI_WindowLogo < TestUI_Class

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
  # * Window_Logo by default
  #--------------------------------------------------------------------------
  def test_default
    w = Window_Logo.new(0,0,640,450,"logo")
    @windows.push(w)
    return true
  end
  
end
