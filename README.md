# rmvx-ebjb-core

Contains common functions and classes for different uses in the EBJB scripts. You can use them as well for your needs. The main features are divided into these four groups : Controls & User Controls, Filters & Comparers, Windows Add-ons and Miscellaneous.

## Table of contents

- [Quick start](#quick-start)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [Creators](#creators)
- [Credits](#credits)

## Quick start

- Run this command to combine external scripts source into one file. `ruby build-ext.rb`
- Run this command to combine core scripts source into one file. `ruby build.rb`
- Copy the resulting files into your RPG Maker VX project 
  > Watch out ! The external scripts needs to be before the core scripts.

OR

- There is an already pre-compiled demo with the classic sample project.

## Documentation

### Controls & User Controls
The concept of these is to encapsulate the code that is necessary to draw something on a window in classes that are reusable on every window. A control is the basic thing you want to draw on a window (ex.: a label, a line, an image, etc). An user control is a collection of controls that represents something more complex on a window (ex.: a composite of a label and an icon, a bar that fills like a classic HP bar, a graph for element resistances).

Every control can be drawn in a window, a sprite or a bitmap object. You can use them in different ways, but the following example is the main usage with a window. For specific constructor parameters, see the documentation in the control classes.

#### Instructions for usage
Every control can be drawn in a window, a sprite or a bitmap object. You can use them in different ways, but the following example is the main usage with a window. For specific constructor parameters, see the documentation in the control classes.

```ruby
class Window
  attr_reader :ctrl
     
  def initialize(...)
    # Initialization of the control (you can enter any coordinates for the Rect)
    @ctrl = Control.new(self, Rect.new(0,0,self.contents.width,WLH), ...)
    window_update(...)
  end
 
  #This method is NOT the update method which is called for each frame, this is a custom method to update the window contents
  def window_update(...)
    # If you need to allow the update of the content of the control, you call the window_update method with the new values)
    @ctrl.property = ...
  end
 
  def refresh()
    self.contents.clear
    # This will draw the control on the window
    @ctrl.draw()
  end
end
```

### Filters & Comparers
The concept behind these is to offer an easy customizable way to add new filters and comparers for your filtering and sorting needs. A filter is what will allow you to filter a list of objects. A comparer is what will allow you to sort a list of objects.

There are no limits to what you need to filter or sort. You can create the one that fits your needs easily or inherits one of these and customize it. 

#### Instructions for usage
The following example is how to use a Filter or a Comparer object.

```ruby
# If obj is a Comparer object
new_list = list.sort{|x,y| obj.compare(x,y)}
 
# If obj is a Filter object
new_list = list.find_all{|x| obj.apply(x)}
```

### Windows Add-ons
When creating my scripts, I found out that I needed new kinds of windows that weren't available by default. Also, I had special needs for the Window_Selectable, which is why I edited it a lot, for the best I hope...

### Miscellaneous
In Ruby, there is a method called require which allow you to add an external Ruby file or a library to your program. I wanted to add this functionality, so this is the reason why I added the require definition.

I had a script on which I needed to be able to use the same scene management but was called from two completely different places and I didn't want to copy the scene management code in each scene. So, I created a Sub_Scene_Base to act as a superclass to be able to reuse the Scene within another one. Watch out though, you will need to adapt your Scene correctly and also the one in which you want to reuse it. Since the latter is the running scene, you will need to call the methods from the superclass like start, terminate or update of the reusable scene.

## Contributing

Still in development...

No test framework was used, only some custom-made classes which allowed me to run tests with a console output.  

### Tests

Contains the script used for testing within the project, these aren't classic ruby integration tests.

## Creators

- <https://github.com/chaoshades>

## Credits 

- Yanfly : Yanfly 6 - Core Engine
- MACL Authors : Modules.Zlib
- Wortana : Wortana's 'gradient_fill_rect' Bug Fix
- KGC : Window_Command Addon
