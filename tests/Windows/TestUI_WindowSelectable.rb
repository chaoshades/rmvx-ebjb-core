#==============================================================================
# ** TestUI_WindowSelectable
#------------------------------------------------------------------------------
#  Unit tests for the window selectable
#==============================================================================

class TestUI_WindowSelectable < TestUI_Class
  
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
  # * Window_Selectable by default
  #--------------------------------------------------------------------------
  def test_default
    w = Window_Selectable_Implemented.new(0,0,160,128,$data_items.compact)
    @windows.push(w)
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable with custom line height
  #--------------------------------------------------------------------------
  def test_line_height
    w = Window_Selectable_Implemented.new(160,0,160,128,$data_items.compact, 48)
    @windows.push(w)
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable with invisible cursor
  #--------------------------------------------------------------------------
  def test_cursor_hidden
    w = Window_Selectable_Implemented.new(320,0,160,128,$data_items.compact, 24, false)
    @windows.push(w)
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable with custom line width
  #--------------------------------------------------------------------------
  def test_line_width
    w = Window_Selectable_Implemented.new(480,0,160,128,$data_items.compact, 24, true, 24)
    @windows.push(w)
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable with contents aligned to left
  #--------------------------------------------------------------------------
  def test_alignLeft
    w = Window_Selectable_Implemented.new(0,128,160,128,$data_items.compact, 24, true, 24, 0)
    @windows.push(w)
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable with contents aligned to center
  #--------------------------------------------------------------------------
  def test_alignCenter
    w = Window_Selectable_Implemented.new(160,128,160,128,$data_items.compact, 24, true, 24, 1)
    @windows.push(w)
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable with contents aligned to right
  #--------------------------------------------------------------------------
  def test_alignRight
    w = Window_Selectable_Implemented.new(320,128,160,128,$data_items.compact, 24, true, 24, 2)
    @windows.push(w)
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable with cursor blocking
  #--------------------------------------------------------------------------
  def test_block_cursor
    w = Window_Selectable_Implemented.new(480,128,160,128,$data_items.compact)
    w.block_cursor = true;
    @windows.push(w)
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable with detail window
  #--------------------------------------------------------------------------
  def test_detail_window
    detail_window = Window_ItemDetails.new(0,384,640,96,nil)
    detail_window.visible = false
    help_window = Window_Info_Help.new(0, 384, 640, 96, nil)
    
    w = Window_Selectable_Implemented.new(0,256,160,128,$data_items.compact)
    w.help_window = help_window
    w.detail_window = detail_window
    @windows.push(w)
    @windows.push(help_window)
    @windows.push(detail_window)
  end
  
end


# Custom class for testing purpose of Window_Selectable
class Window_Selectable_Implemented < Window_Selectable

  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Array for CLabel for name of each item
  attr_reader :cLabelsList
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get the current item
  #--------------------------------------------------------------------------
  # GET
  def selected_item
    return (self.index < 0 ? nil : @data[self.index])
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window x-coordinate
  #     y : window y-coordinate
  #     width : window width
  #     height : window height
  #     items : items
  #     line_h : line height
  #     visible_cursor : true to show the cursor, else false
  #     line_w  : window line width
  #     align : items alignment
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, items, line_h = WLH, visible_cursor = true,
                 line_w = 0, align = 0)
    super(x, y, width, height, 10, line_h, visible_cursor, line_w, align)

    @cLabelsList = []

    window_update(items)
    self.index = 0
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update
  #     items : items
  #--------------------------------------------------------------------------
  def window_update(items)
    @data = []
    for i in @data.size .. 4-1
      @data.push(nil)
    end
    
    if items != nil
      index = 0
      for item in items
        @data[index] = item
        index += 1
      end
    end
    
    @item_max = @data.size
    create_contents()
    @cLabelsList.clear()
    for i in 0..@item_max-1
      @cLabelsList.push(create_item(i))
    end
    refresh()
  end
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh()
    self.contents.clear
    @cLabelsList.each() { |cLabel| cLabel.draw() }
  end
  
  #--------------------------------------------------------------------------
  # * Update Help Text
  #--------------------------------------------------------------------------
  def update_help
    if selected_item != nil
      @help_window.window_update(selected_item.description)
    else
      @help_window.window_update("")
    end
  end
  
  #--------------------------------------------------------------------------
  # * Update Detail Window
  #--------------------------------------------------------------------------
  def update_detail
    if selected_item != nil
      @detail_window.window_update(selected_item)
    else
      @detail_window.window_update(nil)
    end
  end
  
  #--------------------------------------------------------------------------
  # * Determine if help/detail window can be switched
  #--------------------------------------------------------------------------
  def is_switchable
    return selected_item != nil && 
           selected_item.is_a?(RPG::Item) && detail_window.is_a?(Window_ItemDetails)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Create an item for LabelsList
  #     index : item index
  #--------------------------------------------------------------------------
  def create_item(index)
    item = @data[index]
    rect = item_rect(index)
    
    cLabel = CLabel.new(self, rect, item.name)
                                  
    return cLabel
  end
  private :create_item
  
end
