#==============================================================================
# ** UCGraph
#------------------------------------------------------------------------------
#  Represents a Graph user control on a window
#==============================================================================

class UCGraph < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Polygon control for the background of the graph
  attr_reader   :cBackground
  # Polygon control for the borders of the graph
  attr_reader   :cBorders
  # Coordinates (X,Y) of the center of the graph
  attr_accessor :ox, :oy
  # Radius of the graph
  attr_accessor :radius
  # GraphElement objects list (see GraphElement)
  attr_accessor :elements
  # Pattern used to format the value
  attr_accessor :pattern
  # Maximum value (to have a positive filled branch)
  attr_accessor :max_value
  # Minimum value (to have a negative filled branch)
  attr_accessor :min_value
  # Font for the values of the graph
  attr_accessor :font
  # Positive fill color 1 of the user control 
  attr_reader   :pos_color1
  # Positive fill color 2 of the user control (used for gradient) 
  attr_reader   :pos_color2
  # Negative fill color 1 of the user control 
  attr_reader   :neg_color1
  # Negative fill color 2 of the user control (used for gradient) 
  attr_reader   :neg_color2
  # True to hide the values of the graph, else false
  attr_accessor :hide_values
  # Padding (in pixels) added to the positions of the values
  attr_accessor :padding
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Triangle controls list to draw each branch of the graph
  @cTriangles = nil
  # LabelIcon user controls list to draw the values of each branch of the graph
  @ucLabelIcons = nil
  # Window in which the user control will be drawn 
  @window = nil
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cBackground.visible = visible if @cBackground != nil
    @cBorders.visible = visible if @cBorders != nil
    if @cTriangles != nil
      for triangle in @cTriangles
        triangle.visible = visible
      end
    end
    if @ucLabelIcons != nil
      for lblIcon in @ucLabelIcons
        lblIcon.visible = visible
      end
    end
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cBackground.active = active if @cBackground != nil
    @cBorders.active = active if @cBorders != nil
    if @cTriangles != nil
      for triangle in @cTriangles
        triangle.active = active
      end
    end
    if @ucLabelIcons != nil
      for lblIcon in @ucLabelIcons
        lblIcon.active = active
      end
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     ox : x value of the coordinate of the center of the graph
  #     oy : y value of the coordinate of the center of the graph
  #     radius : radius of the graph
  #     elements : GraphElement objects list (see GraphElement)
  #     pattern : pattern used to format the value
  #     max_value : maximum value (to have a positive filled branch)
  #     min_value : minimum value (to have a negative filled branch)
  #     font : font for the values of the graph
  #     pos_color1 : positive fill color 1 of the user control
  #     pos_color2 : positive fill color 2 of the user control (used for gradient) 
  #     neg_color1 : negative fill color 1 of the user control
  #     neg_color2 : negative fill color 2 of the user control (used for gradient) 
  #     back_color : background color
  #     border : size of the border
  #     br_color1 : border color 1
  #     br_color2 : border color 2 (used for gradient) 
  #     hide_values : true to hide the values of the graph, else false
  #     padding : padding (in pixels) added to the positions of the values
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, ox, oy, radius, elements, pattern, max_value, min_value,
                 font, pos_color1, pos_color2, neg_color1, neg_color2, 
                 back_color=nil, border=0, br_color1=nil, br_color2=br_color1,
                 hide_values=false, padding=15, active=true, visible=true)
    super(active, visible)
    @window = window
    self.ox = ox
    self.oy = oy
    self.radius = radius - padding
    self.elements = elements
    self.pattern = pattern
    self.max_value = max_value
    self.min_value = min_value
    self.hide_values = hide_values
    self.padding = padding
    self.font = font
    
    if !back_color.nil?
      @cBackground = CPolygon.new(window, nil, back_color, true)
      @cBackground.active = active
      @cBackground.visible = visible
    end
    
    if border > 0 && !br_color1.nil?
      @cBorders = CPolygon.new(window, nil, nil, false, nil,
                               border, br_color1, br_color2)
      @cBorders.active = active
      @cBorders.visible = visible
    end
  
    @pos_color1 = pos_color1
    @pos_color2 = pos_color2
    @neg_color1 = neg_color1
    @neg_color2 = neg_color2
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the graph on the window
  #--------------------------------------------------------------------------
  def draw()
    # Return if number of elements is less than or 3
    return if self.elements == nil
    return if self.elements.size <= 3
    
    # Find the angle in radians to split the points
    angle = 2 * Math::PI / self.elements.size

    # Determine the graph vertices
    local_vertices = []
    for i in 0..self.elements.size-1
      x = Integer(self.radius * Math.cos(angle*i))
      y = Integer(self.radius * Math.sin(angle*i))
      local_vertices.push([x,y])
    end

    # Create the drawing elements
    drawingElements = []
    percentage = 0
    color1 = nil
    color2 = nil
    
    for i in 0..local_vertices.size-1
      elem = self.elements[i]

      max = self.max_value
      if (max == nil)
        max = elem.value
      end
      if (max == 0)
        max = 1
      end
      
      min = self.min_value
      if (min == nil)
        min = elem.value
      end
      if (min == 0)
        min = 1
      end
      
      # Switch colors when negative value
      if elem.value >= 0
        color1 = @pos_color1
        color2 = @pos_color2
        percentage = (elem.value / max.to_f).abs
      else
        color1 = @neg_color1
        color2 = @neg_color2
        percentage = (elem.value / min.to_f).abs
      end

      x2 = Integer(local_vertices[i-1][0] * percentage)
      y2 = Integer(local_vertices[i-1][1] * percentage)
      x3 = Integer(local_vertices[i][0] * percentage)
      y3 = Integer(local_vertices[i][1] * percentage)
      
      # Create a triangle for an element
      triangle = CTriangle.new(@window, 0, 0, x2, y2, x3, y3, color1, true, color2)
      triangle.active = active
      triangle.visible = visible
      
      # Determine labels position     
      i -= 1
      x = Integer((self.radius + self.padding) * Math.cos(angle*i + angle/2))
      y = Integer((self.radius + self.padding)* Math.sin(angle*i + angle/2))
      
      # Add every information for an element
      drawingElements.push([elem, triangle, [x, y]])
    end
    
    # Draw background of the graph
    if !@cBackground.nil?
      @cBackground.vertices = copy_vertices(local_vertices)
      @cBackground.translate(ox,oy)
      @cBackground.draw()
    end
    
    # Draw each elements of the graph 
    @cTriangles = []
    @ucLabelIcons = []
    
    for dElem in drawingElements
      element = dElem[0]
      triangle = dElem[1]
      x = dElem[2][0] + ox
      y = dElem[2][1] + oy
      
      # Update labels position
      x-=12
      y-=12
      # Left side
      if x < ox
        x_label = x - 48
        label_align = 2
      else
        x_label = x + 24
        label_align = 0
      end
      
      if self.hide_values
        lblIcon = UCIcon.new(@window, Rect.new(x,y,24,24), element.iconIndex)
        lblIcon.active = active
        lblIcon.visible = visible
      else
        lblIcon = UCLabelIcon.new(@window, Rect.new(x_label,y,48,24), Rect.new(x,y,24,24), 
                                  nil, element.iconIndex,
                                  active, visible)
        if (self.pattern != nil)
          lblIcon.cLabel.text = sprintf(self.pattern, element.value.to_s)
        else
          lblIcon.cLabel.text = element.value.to_s
        end
        lblIcon.cLabel.font = self.font
        lblIcon.cLabel.align = label_align
      end
      triangle.translate(ox,oy)
      
      @cTriangles.push(triangle)
      @ucLabelIcons.push(lblIcon)
      
      lblIcon.draw()
      triangle.draw()
    end
    
    # Draw borders of the graph
    if !@cBorders.nil?
      @cBorders.vertices = copy_vertices(local_vertices)
      @cBorders.translate(ox,oy)
      @cBorders.draw()
    end
    
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Deep copy the vertices
  #     vertices : vertices to copy
  #--------------------------------------------------------------------------
  def copy_vertices(vertices)
    deep_copy = []
    
    for i in 0..vertices.size-1
      x = vertices[i][0]
      y = vertices[i][1]
      deep_copy.push([x,y])
    end
    
    return deep_copy
  end
  private:copy_vertices
  
end
