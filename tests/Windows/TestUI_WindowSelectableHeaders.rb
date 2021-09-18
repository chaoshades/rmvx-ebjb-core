#==============================================================================
# ** TestUI_WindowSelectableHeaders
#------------------------------------------------------------------------------
#  Unit tests for the window selectable headers
#==============================================================================

class TestUI_WindowSelectableHeaders < TestUI_Class

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
  # * Window_Selectable_Headers by default
  #--------------------------------------------------------------------------
  def test_default
    w = Window_Command.new(160, ["1", "2", "3", "4"])
    @windows.push(w)
    w = Window_Selectable_Headers.new(w)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable_Headers with a default header
  #--------------------------------------------------------------------------
  def test_defaultAddHeader
    w = Window_Command.new(160, ["1", "2", "3", "4"])
    w.x = 160
    @windows.push(w)
    w = Window_Selectable_Headers.new(w)
    w.addHeader(nil, 0, 160)
    w.refresh
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable_Headers with a custom text header
  #--------------------------------------------------------------------------
  def test_addHeader
    w = Window_Command.new(160, ["1", "2", "3", "4"])
    w.x = 320
    @windows.push(w)
    w = Window_Selectable_Headers.new(w)
    w.addHeader("Commands", 0, 160)
    w.refresh
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable_Headers with a custom text header with scrolling
  #--------------------------------------------------------------------------
  def test_addHeaderScroll
    w = Window_Command.new(160, ["1", "2", "3", "4"])
    w.x = 480
    w.height = 80
    @windows.push(w)
    w = Window_Selectable_Headers.new(w)
    w.addHeader("Commands", 0, 160)
    w.refresh
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable_Headers with multiple headers
  #--------------------------------------------------------------------------
  def test_multipleHeaders
    # Values are tricked here, but normally would be a custom 
    # window with a custom draw_item function
    w = Window_Command.new(160, ["1-  Potion         10", 
                                 "2-  Scroll        100", 
                                 "3-  Elixir       2500", 
                                 "4-  Iron Axe     900"])
    w.y = 160
    @windows.push(w)
    w = Window_Selectable_Headers.new(w)
    w.addHeader("ID", 0, 20)
    w.addHeader("Text", 20, 60)
    w.addHeader("Value", 80, 40)
    w.refresh
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable_Headers with multiple headers
  #--------------------------------------------------------------------------
  def test_multipleHeadersScroll
    # Values are tricked here, but normally would be a custom 
    # window with a custom draw_item function
    w = Window_Command.new(160, ["1-  Potion           10", 
                                 "2-  Scroll          100", 
                                 "3-  Elixir         2500", 
                                 "4-  Iron Axe         900"])
    w.x = 480
    w.y = 112
    w.height = 80
    @windows.push(w)
    w = Window_Selectable_Headers.new(w)
    w.addHeader("ID", 0, 20)
    w.addHeader("Text", 20, 60)
    w.addHeader("Value", 80, 40)
    w.refresh
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable_Headers with a custom header height
  #--------------------------------------------------------------------------
  def test_customHeaderHeight
    w = Window_Command.new(160, ["1", "2", "3", "4"])
    w.x = 160
    w.y = 160
    @windows.push(w)
    w = Window_Selectable_Headers.new(w, 50)
    w.addHeader("Commands", 0, 160)
    w.refresh
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable_Headers with a custom header font
  #--------------------------------------------------------------------------
  def test_customHeaderFont
    w = Window_Command.new(160, ["1", "2", "3", "4"])
    w.x = 320
    w.y = 160
    @windows.push(w)
    w = Window_Selectable_Headers.new(w)
    w.addHeader("Commands", 0, 160, 0, Font.bold_font)
    w.refresh
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable_Headers with custom header align
  #--------------------------------------------------------------------------
  def test_customHeaderAlign
    w = Window_Command.new(320, ["1", "2", "3", "4"])
    w.y = 346
    w.height = 80
    @windows.push(w)
    w = Window_Selectable_Headers.new(w)
    w.addHeader("ID", 0, 48, 0)
    w.addHeader("Text", 48, 160, 1)
    w.addHeader("Value", 208, 80, 2)
    w.refresh
    @windows.push(w)
    return true
  end
  
end
