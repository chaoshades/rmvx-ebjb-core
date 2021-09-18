#==============================================================================
# ** TestUI_WindowInfoHelp
#------------------------------------------------------------------------------
#  Unit tests for the window info help
#==============================================================================

class TestUI_WindowInfoHelp < TestUI_Class
  
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
  # * Window_Info_Help by default
  #--------------------------------------------------------------------------
  def test_default
    w = Window_Info_Help.new(0,0,640,96,nil)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Info_Help with simple text
  #--------------------------------------------------------------------------
  def test_simpleText
    w = Window_Info_Help.new(0,96,640,96,"Simple help")
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Info_Help with multiline text
  #--------------------------------------------------------------------------
  def test_multilineText
    w = Window_Info_Help.new(0,192,640,96,MULTILINE_TEXT)
    @windows.push(w)
    return true
  end
  
end
