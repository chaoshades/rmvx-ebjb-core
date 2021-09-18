#==============================================================================
# ** TestUI_UCGraph_2
#------------------------------------------------------------------------------
#  Unit tests for the UCGraph user control (part 2)
#==============================================================================

class TestUI_UCGraph_2 < TestUI_Class
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Setup tests
  #--------------------------------------------------------------------------
  def testFixtureSetup()
    # bitmap test
    @viewport_bitmap = Viewport.new(0, 0, 640, 450)
    @sprite_bitmap = Sprite.new(@viewport_bitmap)
    @bitmap = Bitmap.new(640, 450)
    @sprite_bitmap.bitmap = @bitmap
    
    # sprite test
    @viewport = Viewport.new(0, 0, 640, 450)
    @sprite = Sprite.new(@viewport)
    @sprite.bitmap = Bitmap.new(640, 450)
    
    # window test
    @window = Window_Base.new(0, 0, 640, 450)
    
    @window.visible = true
    @sprite.visible = false
    @sprite_bitmap.visible = false
    @window_duration = 240
    @sprite_duration = nil
    @bitmap_duration = nil
    
    @elements = []
    for i in 9..16
      @elements.push(GraphElement.new($data_elements[i].icon_index, -100 + 25 * (i-9)))
    end
    
    @uc_graphsToggle = []
    @up = true
    # setup your objects for the tests (if needed)
  end
  
  #--------------------------------------------------------------------------
  # * Tear down tests
  #--------------------------------------------------------------------------
  def testFixtureTearDown()
    @window.dispose
    @window = nil
    
    @sprite.bitmap.dispose
    @sprite.dispose
    @sprite = nil
    @viewport.dispose
    @viewport = nil
    
    @viewport_bitmap.dispose
    @viewport_bitmap = nil
    @sprite_bitmap.bitmap.dispose
    @sprite_bitmap.dispose
    @sprite_bitmap = nil

    @elements = nil
    @uc_graphsToggle = nil
    # destroy your objects when the tests are finished (if needed)
  end
  
  #--------------------------------------------------------------------------
  # * Frame update
  #--------------------------------------------------------------------------
  def update()
    @window.update
    @viewport.update
    @sprite.update
    @viewport_bitmap.update
    @sprite_bitmap.update
    
    if @window_duration != nil
      if @window_duration == 0
        @window.visible = false
        @sprite_duration = 240
        @sprite.visible = true
        @window_duration = nil
      elsif @window_duration > 0
        @window_duration -= 1
      end
    end
    
    if @sprite_duration != nil
      if @sprite_duration == 0
        @sprite.visible = false
        @bitmap_duration = 240
        @sprite_bitmap.visible = true
        @sprite_duration = nil
      elsif @sprite_duration > 0
        @sprite_duration -= 1
      end
    end
    
    if @bitmap_duration != nil
      if @bitmap_duration == 0
        @sprite_bitmap.visible = false
        @window_duration = 240
        @window.visible = true
        @bitmap_duration = nil
      elsif @bitmap_duration > 0
        @bitmap_duration -= 1
      end
    end
    
    if @upDown_duration == 0
      upDownToggle()
    else
      @upDown_duration -= 1
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Tests
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * UCGraph with different number of elements
  #--------------------------------------------------------------------------
  def test_elementsNumber
    temp = []
    for e in @elements
      temp.push(e)
    end
    while temp.size > 3
      [@window, @sprite, @bitmap].each{|container|
          uc = UCGraph.new(container, 100 + 200*(temp.size%3.to_i), 180 + 120*(temp.size%2.to_i), 50, temp, nil, 100, -100, Font.normal_font,
                           Color.hp_gauge_color1, Color.hp_gauge_color2,
                           Color.mp_gauge_color1, Color.mp_gauge_color2, nil,
                           1, Color.normal_color)
          uc.draw()
      }
      temp.delete_at(temp.size-1)
    end
    return true
  end
 
  #--------------------------------------------------------------------------
  # * UCGraph when changing value
  #--------------------------------------------------------------------------
  def test_upDownToggle
    [@window, @sprite, @bitmap].each{|container|
      uc = UCGraph.new(container, 100, 60, 50, @elements, nil, 100, -100, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2)
      @uc_graphsToggle.push(uc)
      uc = UCGraph.new(container, 300, 60, 50, @elements, nil, 100, -100, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2, nil,
                       1, Color.normal_color)
      @uc_graphsToggle.push(uc)
    }
    upDownToggle()
    return true
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
    
  #--------------------------------------------------------------------------
  # * Toggle between up/down to change value of UCGraph
  #--------------------------------------------------------------------------
  def upDownToggle()
    @upDown_duration = 6
    @window.contents.clear_rect(Rect.new(0, 0, 400, 120))
    @sprite.bitmap.clear_rect(Rect.new(0, 0, 400, 120))
    @bitmap.clear_rect(Rect.new(0, 0, 400, 120))
    for uc in @uc_graphsToggle
      for elem in uc.elements
        if (elem.value == uc.max_value)
          @up = false
        elsif (elem.value == uc.min_value)
          @up = true
        end
        
        if (@up)
          elem.value += 5
        else
          elem.value -= 5
        end

      end
      uc.draw()
    end
  end
  private :upDownToggle
  
end
