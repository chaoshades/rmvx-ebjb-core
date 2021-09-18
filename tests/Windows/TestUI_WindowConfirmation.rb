#==============================================================================
# ** TestUI_WindowConfirmation
#------------------------------------------------------------------------------
#  Unit tests for the window confirmation
#==============================================================================

class TestUI_WindowConfirmation < TestUI_Class

  #//////////////////////////////////////////////////////////////////////////
  # * Constants
  #//////////////////////////////////////////////////////////////////////////
  
  MULTILINE_TEXT = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam odio tellus, eleifend gravida imperdiet ut, auctor sed sapien. Donec pharetra pulvinar ultrices. Proin sit amet sem facilisis ligula laoreet consectetur. Nulla elementum lobortis sem nec auctor. Suspendisse ullamcorper tortor sed sem dapibus fermentum."
  
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
  # * Window_Confirmation by default
  #--------------------------------------------------------------------------
  def test_default
    w = Window_Confirmation.new(0,0,320,nil)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Confirmation with custom text
  #--------------------------------------------------------------------------
  def test_text
    w = Window_Confirmation.new(320,0,320,"Are you sure ?")
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Confirmation with custom commands text
  #--------------------------------------------------------------------------
  def test_customCommandsText
    w = Window_Confirmation.new(0,80,320,"Êtes-vous certain ?", "Oui", "Non")
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Confirmation with custom default command index
  #--------------------------------------------------------------------------
  def test_defaultIndex
    w = Window_Confirmation.new(320,80,320,"Are you sure ?", "Yes", "No", 0)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Confirmation with multiline text
  #--------------------------------------------------------------------------
  def test_multilineText
    w = Window_Confirmation.new(0,160,640,MULTILINE_TEXT)
    @windows.push(w)
    return true
  end
  
end
