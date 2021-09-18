#==============================================================================
# ** TestUI_WindowSelectableMultiple
#------------------------------------------------------------------------------
#  Unit tests for the window selectable multiple
#==============================================================================

class TestUI_WindowSelectableMultiple < TestUI_Class
  
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
  # * Window_Selectable_Multiple by default
  #--------------------------------------------------------------------------
  def test_default
    w = Window_Selectable_Multiple_Implemented.new(0,0,640,128,$data_actors.compact)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable_Multiple with custom max indexes
  #--------------------------------------------------------------------------
  def test_max_indexes
    w = Window_Selectable_Multiple_Implemented.new(0,128,640,128,$data_actors.compact,4)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Selectable_Multiple with custom block selection
  #--------------------------------------------------------------------------
  def test_block_selection
    w = Window_Selectable_Multiple_Implemented.new(0,256,640,128,$game_party.members)
    @windows.push(w)
    return true
  end
  
end

# Custom class for testing purpose of Window_Selectable_Multiple
class Window_Selectable_Multiple_Implemented < Window_Selectable_Multiple

  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Array for UCCharFace for the face of each member of the party
  attr_reader :ucCharFacesList
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window x-coordinate
  #     y : window y-coordinate
  #     width : window width
  #     height : window height
  #     members : party members
  #     max_indexes : number of selected indexes to keep
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, members, max_indexes = 2)
    super(x, y, width, height, 10, 96, true, 0, 0, max_indexes)
    @column_max = 4
    @ucCharFacesList = []

    window_update(members)
    self.index = 0
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update
  #     members : party members
  #--------------------------------------------------------------------------
  def window_update(members)
    @data = []
    for i in @data.size .. 4-1
      @data.push(nil)
    end
    
    if members != nil
      index = 0
      for member in members
        @data[index] = member
        index += 1
      end
    end
    
    @item_max = @data.size
    create_contents()
    @ucCharFacesList.clear()
    for i in 0..@item_max-1
      @ucCharFacesList.push(create_item(i))
    end
    refresh()
  end
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh()
    self.contents.clear
    @ucCharFacesList.each() { |ucCharFace| ucCharFace.draw() }
  end
  
  #--------------------------------------------------------------------------
  # * Block selection
  #--------------------------------------------------------------------------
  def block_selection
    result = false
    if @ucCharFacesList.length == 4
      result = true
    end
    return result
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Create an item for CharFacesList
  #     index : item index
  #--------------------------------------------------------------------------
  def create_item(index)
    actor = @data[index]
    rect = item_rect(index)
    
    ucChar = UCCharacterFace.new(self, rect, actor, 1)
                                  
    return ucChar
  end
  private :create_item
  
end
