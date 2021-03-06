#==============================================================================
# ** Yanfly 6 - Core Engine
# Author: Yanfly
# Version: x.x
#------------------------------------------------------------------------------
# See Introduction below...
#------------------------------------------------------------------------------
# Changes for EBJB_Core :
# - Y6 Settings & Font Settings have been moved to Core_Config 
#   to group configuration at the same place.
# - method start_animation : RATE constant have been removed 
#   to use the Y6::SETTING::ANIMATION_RATE directly
# - method draw_text_ce : IF for the alias creation have been removed to
#   make a IF in the method to call the default draw method if outline is false
#==============================================================================

$imported = {} if $imported == nil
$imported["Y6-Core"] = true

#==============================================================================
# Updates
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# o 2011.10.30 - Fixed bug that caused selling to show wrong calculations.
# o 2011.10.10 - Fixed bug that called up the wrong module constant.
# o 2011.09.03 - Updated enemies to appear centered on the screen with
#                different resolution sizes.
# o 2011.09.01 - Battle Viewport bugfix.
# o 2011.08.30 - Finished Y6 version of script.
# 
#==============================================================================
# Introduction
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This is a compilation of all the various bug fixes and upgrades dedicated to
# making RPG Maker VX and RGSS2 run efficiently and effectively. It is highly
# recommended that you place this script at the top of your script listing (but
# under Materials) so that as many Y6 scripts work correctly and properly.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Animation Speed Fix
# -----------------------------------------------------------------------------
# RPG Maker VX uses the same animation speed that of RPG Maker XP. However, for
# XP, the default FPS is 40 frames per second whereas in RPG Maker VX, the FPS
# is 60 frames per second. This fix will up the animation speed unless decided
# otherwise by the user.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Animation Overlay Fix
# -----------------------------------------------------------------------------
# In battle, when an animation targeting the whole screen is being used, the
# animation is actually played multiple times. This causes an exponentially
# growing overlay in both graphics and sound and plays out rather choppy, too.
# The fix will cause the animation to play only once if it is an overlay. And
# unlike the YERD version, this one also allows non-overlayed enemies to flash.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Battle Time Over Window Bug
# -----------------------------------------------------------------------------
# When a battle ends because of a timer, windows that were left open remain
# open by default. Thus, they can never be terminated unless the game were to
# be reset. This is fixed so that any windows that were left open at a time
# based termination of the battle will automatically be disposed.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Battle Turn Order Fix
# -----------------------------------------------------------------------------
# For those that are using the default battle system, you've probably realized
# sooner or later that turn order is only calculated once at the start of each
# turn and retains that order even if speed has been changed in between turns.
# This means that enemies which your actors have slowed on the same turn will
# still act in the same order calculated for that turn. Agility status effects
# and the like do not take effect until the following turn, which may become
# rather useless for some. This script fixes that and recalculates turn order
# after each and every action.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Damage Variance Fix
# -----------------------------------------------------------------------------
# Skills have a variable called variance that gives them a random modifier for
# damage so that it doesn't appear the same as always. However, the formula for
# applying variance for a damage skill and the formula for a healing skill are
# completely incompatible since the variance treats healing calculations as
# damage calculations. This fix will adjust the calculations properly.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Disposed Window Bug
# -----------------------------------------------------------------------------
# Sometimes when a window is disposed but hasn't been set to nil, the game will
# crash without even telling you which window has been disposed. Although this
# will prevent the crash, in $TEST and $BTEST mode (test play mode), a pop up
# appears to list which window variable needs to be cleared so you can maximize
# your code better. The latter feature is mostly for debug purposes.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Enemy Reappear Fix
# -----------------------------------------------------------------------------
# In the event that a state is applied to a monster and that monster dies, if
# the state's timer runs out, a message appears that the monster is suddenly
# cured of poison or whatever. Not only does the message appear, the monster's
# sprite reappears in battle, too. The monster, however, is not selectable.
# This script  will fix that problem by halting the state removal process.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Game Interpreter Change Variable Command
# -----------------------------------------------------------------------------
# By default, the English version of RPG Maker VX has faulty coding for the
# ever used Control Variables event command. The Game Interpreter Fix corrects
# the problem and makes it function as it should.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Menu Actor Switch Fix
# -----------------------------------------------------------------------------
# When using L or R to switch between actors in the Skill and Equip menus, what
# is strange is that upon leaving those menus and selecting the Skill or Equip
# option again, it will not target the newly switched actor, but rather, the
# previous. This little fix will help update that method.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Message Window Actor Fix
# -----------------------------------------------------------------------------
# Previously, when using \n[0] in the message window, it would not return the
# leading actor like it did normally before in RPG Maker 2000 and 2003. Now,
# it will have the functionality to do so again. And as an added bonus, using
# the \f[0] tag will cause the message window to use the leading actor's face.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Prevent Skill Scene Actor Switch
# -----------------------------------------------------------------------------
# By default, pressing L and R in the Skill Scene causes the scene to swap to
# the previous actor and next actor respectively. This is problematic if the
# actor has a lot of skills that would require scrolling and thus, the L and R
# buttons will be locked if more than 22 skills are present (the amount that
# would require L and R to scroll). This amount is adjustable in the module to
# change accordingly to different sized lists should the Skill Scene be
# affected by other scripts.
# 
# -----------------------------------------------------------------------------
# Bug Fix: State Resistance Fix
# -----------------------------------------------------------------------------
# When RPG Maker VX checks if an enemy is resistant against a certain state for
# applying states, it will always return false regardless of what probability
# rate given to the enemy. This script will change the definition altogether for
# enemies and returns the check as true if the state has a working chance of
# 10% or lower against that particular enemy. Nothing will be considered
# resistant against the death state, however.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Usable Items Only Fix
# -----------------------------------------------------------------------------
# This prevents non-battle usable items to be included into the item menu
# during battle. What VX did originally was allow any kind of item so long as
# it was an item type (not weapon type or armour type) despite whether or not
# it was usable in battle. This one just limits the item menu to the ones
# usable in a battle. For those with KGC's Usable Equipment script, this script
# is compatible with it.
# 
# -----------------------------------------------------------------------------
# Bug Fix: Window Interface Fixes
# -----------------------------------------------------------------------------
# This script will automatically adjust visible gauges, fonts, and other items
# to prevent them from glitching up. These glitches include HP and MP gauges
# extending past their default limits, font colours not adjusting to the proper
# window colour based on the window skin, and more.
# 
# -----------------------------------------------------------------------------
# New Features: Font Adjustment and Text Outlines
# -----------------------------------------------------------------------------
# Adjust the default font the game will use here in addition to selecting the
# option to use outlines for text instead of a shadow. Outlines allow for
# improved visibility for the player.
# 
# -----------------------------------------------------------------------------
# New Features: Help Window Upgrade
# -----------------------------------------------------------------------------
# Now, you can use \n[x] and \v[x] in the help window. Using \n[0] will return
# the user's name if applicable. If not, the "User" will be returned. Use this
# to personalize the description windows a bit more. Colour codes not included
# to preserve engine efficiency.
# 
# -----------------------------------------------------------------------------
# New Features: Numeric Digit Grouping
# -----------------------------------------------------------------------------
# This will change various scenes to display numbers in groups where they are
# separated by a comma every three digits. Thus, a number like 1234567 will
# show up as 1,234,567. This allows for players to read numbers quicker.
# 
# -----------------------------------------------------------------------------
# New Features: Screen Resizing
# -----------------------------------------------------------------------------
# Implemented as a core item since the resolution size for VX is too limiting.
# Although you may not increase the resolution more than 640x480, any custom
# resolution less than it (but over 110x10) can be made. The map screens and
# default menus will be automatically adjusted to work with the new resolution
# size. Any other scripts that have custom scenes may or may not be compatible
# with a non-default resolution size.
# 
# -----------------------------------------------------------------------------
# New Features: Shown States Upgrade
# -----------------------------------------------------------------------------
# More technical RPG's use states to produce additional effects. However, the
# creators of those games would encounter problems if they were to use states
# with invisible icons. This fix will cause states with an icon index of 0 to
# be omitted from the shown states. The upgrade of this script will also allow
# the option to display the number of turns left for a state in the upper left
# corner of that state.
# 
# -----------------------------------------------------------------------------
# New Features: Window Settings
# -----------------------------------------------------------------------------
# With this, you can change the colours used for the gauges, the default height
# of gauges, and whatnot. You may also change the colours used for various text
# such as HP, MP, System Colour Text, Improvements, Downgrades, etc.
# 
#==============================================================================
# Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# To install this script, open up your script editor and copy/paste this script
# to an open slot below ???? Materials but above ???? Main. Remember to save.
# 
# -----------------------------------------------------------------------------
# State Tags - Insert the following tags into State noteboxes.
# -----------------------------------------------------------------------------
# <turn colour: x>
# If you want certain states to display the turns remaining in a different
# colour for the sake of distinguishing them or so they'll show up better on
# the state due to colour incompatibility, use this tag in the state's notebox.
# x is equal to the text colour value found in your window skin file.
# 
# <hide state>
# This will cause the state to be not drawn even if it has has no icon. The
# state will appear elsewhere in other state lists, but not in the actor window
# where it'll be extremely intrusive.
# 
#==============================================================================
# Compatibility
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Note: This script may not work with former Yanfly Engine scripts.
#       Use Yanfly Engine 6 scripts to work with this if available.
#==============================================================================

# *****************************************************************************
# Y6 SETTINGS HAVE BEEN MOVED TO CORE_CONFIG TO EASE CONFIGURATION
# *****************************************************************************

#==============================================================================
# Editting anything past this point may potentially result in causing computer
# damage, incontinence, explosion of user's head, coma, death, and/or halitosis
# so edit at your own risk.
#==============================================================================

# *****************************************************************************
# FONT SETTINGS HAVE BEEN MOVED TO CORE_CONFIG TO EASE CONFIGURATION
# *****************************************************************************

module Y6
  module REGEXP
  module STATE
      
    TURN_COLOUR = /<(?:TURN_COLOUR|turn colour|turn color):[ ]*(\d+)>/i
    HIDE_STATE  = /<(?:HIDE_STATE|hide state)>/i
      
  end # STATE
  end # REGEXP
end # Y6

#==============================================================================
# ** Bitmap
#==============================================================================

class Bitmap

  #--------------------------------------------------------------------------
  # alias method: draw_text
  #--------------------------------------------------------------------------
  alias draw_text_ce draw_text unless $@
  def draw_text(*args)
    # ************************************************************************
    # IF MOVED HERE INSTEAD OF OUTSIDE THE ALIAS
    # ************************************************************************
    unless Y6::SETTING::OUTLINE
      draw_text_ce(*args)
      return
    end
    unless self.font.shadow
      draw_text_ce(*args)
      return
    end
    case args.size
    when 2, 3
      dx, dy, dw, dh, text, align =
      args[0].x, args[0].y, args[0].width, args[0].height, args[1],
      args[2].nil? ? 0 : args[2]
    else
      dx, dy, dw, dh, text, align =
      args[0], args[1], args[2], args[3], args[4],
      args[5].nil? ? 0 : args[5]
    end
    original_colour = self.font.color.clone
    self.font.shadow = false
    alpha = self.font.color.alpha
    self.font.color = Color.new(0, 0, 0, alpha)
    draw_text_ce(dx-1, dy-1, dw, dh, text, align)
    draw_text_ce(dx+1, dy-1, dw, dh, text, align)
    draw_text_ce(dx-1, dy+1, dw, dh, text, align)
    draw_text_ce(dx+1, dy+1, dw, dh, text, align)
    self.font.color = original_colour
    draw_text_ce(dx, dy, dw, dh, text, align)
    self.font.shadow = true
  end
  
end # Bitmap

#==============================================================================
# ** Numeric
#==============================================================================

class Numeric
  
  #--------------------------------------------------------------------------
  # new method: group_digits
  #--------------------------------------------------------------------------
  def group(decimal = 2)
    return self unless Y6::SETTING::GROUP_DIGITS
    n1 = self.abs
    string = ""
    n4 = n1 - n1.to_i
    n2 = (n1.to_i.to_s.size - 1) / 3
    n2.times do
      n3 = n1 % 1000
      n1 /= 1000
      string = sprintf(",%03d%s", n3, string)
    end
    string = sprintf("%d%s", n1, string)
    if n4 > 0 or self.is_a?(Float)
      sp = "%." + decimal.to_s + "f"
      n4 = sprintf(sp, n4)
      n4.gsub!("0.", "")
      string = sprintf("%s.%s", string, n4)
    end
    string = "-" + string if self < 0
    return string
  end
    
end # Numeric

#==============================================================================
# ** RPG::State
#==============================================================================

class RPG::State
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :turn_colour
  attr_accessor :hide_state
  
  #--------------------------------------------------------------------------
  # common cache: y6_cache_state_ce
  #--------------------------------------------------------------------------
  def y6_cache_state_ce
    return if @cached_state_ce
    @cached_state_ce = true
    #---
    @turn_colour = Y6::SETTING::STATE_TURN_COLOUR
    @hide_state = false
    #---
    self.note.split(/[\r\n]+/).each { |line|
      case line
      when Y6::REGEXP::STATE::TURN_COLOUR
        @turn_colour = $1.to_i
      when Y6::REGEXP::STATE::HIDE_STATE
        @hide_state = $1.to_i
      end
    } # end self.note.split
  end # y6_cache_state_ce
  
end # RPG::State

#==============================================================================
# ** Scene_Title
#==============================================================================

class Scene_Title < Scene_Base
  
  #--------------------------------------------------------------------------
  # new method: load_bt_database
  #--------------------------------------------------------------------------
  alias load_bt_database_ce load_bt_database unless $@
  def load_bt_database
    load_bt_database_ce
    load_ce_cache
  end
  
  #--------------------------------------------------------------------------
  # alias method: load_database
  #--------------------------------------------------------------------------
  alias load_database_ce load_database unless $@
  def load_database
    load_database_ce
    load_ce_cache
  end
  
  #--------------------------------------------------------------------------
  # new method: load_ce_cache
  #--------------------------------------------------------------------------
  def load_ce_cache
    groups = [$data_states]
    for group in groups
      for obj in group
        obj.y6_cache_state_ce if obj.is_a?(RPG::State)
      end
    end
  end
  
end # Scene_Title

#==============================================================================
# ** Game_Battler
#==============================================================================

class Game_Battler
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :pseudo_ani_id
  attr_accessor :state_turns
  
  #--------------------------------------------------------------------------
  # new method: maxmp_limit
  #--------------------------------------------------------------------------
  def maxmp_limit; return 9999; end
  
  #--------------------------------------------------------------------------
  # alias method: remove_states_auto
  #--------------------------------------------------------------------------
  alias remove_states_auto_ce remove_states_auto unless $@
  def remove_states_auto
    return if self.dead?
    remove_states_auto_ce
  end
  
  #--------------------------------------------------------------------------
  # alias method: clear_sprite_effects
  #--------------------------------------------------------------------------
  alias clear_sprite_effects_ce clear_sprite_effects unless $@
  def clear_sprite_effects
    clear_sprite_effects_ce
    @pseudo_ani_id = 0
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: state_resist?
  #--------------------------------------------------------------------------
  def state_resist?(state_id)
    return false if state_id == 1
    return false if state_probability(state_id) > Y6::SETTING::MIN_STATE_RESIST
    return true
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: apply_variance
  #--------------------------------------------------------------------------
  def apply_variance(damage, variance)
    amp = [damage.abs * variance / 100, 0].max
    if damage > 0
      damage += rand(amp+1) + rand(amp+1)
      damage -= amp
    elsif damage < 0
      damage -= rand(amp+1) + rand(amp+1)
      damage += amp
    end
    return damage
  end
  
end # Game_Battler

#==============================================================================
# ** Game_Actor
#==============================================================================

class Game_Actor < Game_Battler
  
  #--------------------------------------------------------------------------
  # new method: level_limit
  #--------------------------------------------------------------------------
  def level_limit; return 99; end
  
  #--------------------------------------------------------------------------
  # overwrite method: exp_s
  #--------------------------------------------------------------------------
  def exp_s
    return @exp_list[@level+1] > 0 ? @exp.group : "-------"
  end
  #--------------------------------------------------------------------------
  # overwrite method: next_exp_s
  #--------------------------------------------------------------------------
  def next_exp_s
    return @exp_list[@level+1] > 0 ? @exp_list[@level+1].group : "-------"
  end
  #--------------------------------------------------------------------------
  # overwrite method
  #--------------------------------------------------------------------------
  def next_rest_exp_s
    return @exp_list[@level+1] > 0 ?
      (@exp_list[@level+1] - @exp).group : "-------"
  end
  
end # Game_Actor

#==============================================================================
# ** Game_Troop
#==============================================================================

class Game_Troop < Game_Unit
  
  #--------------------------------------------------------------------------
  # overwrite method: setup
  #--------------------------------------------------------------------------
  def setup(troop_id)
    clear
    @troop_id = troop_id
    @enemies = []
    for member in troop.members
      next if $data_enemies[member.enemy_id] == nil
      enemy = Game_Enemy.new(@enemies.size, member.enemy_id)
      enemy.hidden = member.hidden
      enemy.immortal = member.immortal
      enemy.screen_x = member.x + (Graphics.width - 544)/2
      enemy.screen_y = member.y + (Graphics.height - 416)
      @enemies.push(enemy)
    end
    make_unique_names
  end
  
end # Game_Troop

#==============================================================================
# ** Game_Map
#==============================================================================

class Game_Map
  
  #--------------------------------------------------------------------------
  # alias method: setup_scroll
  #--------------------------------------------------------------------------
  alias setup_scroll_game_map_ce setup_scroll unless $@
  def setup_scroll
    setup_scroll_game_map_ce
    @margin_x = (width - (Graphics.width / 32)) * 256 / 2
    @margin_y = (height - (Graphics.height / 32)) * 256 / 2
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: calc_parallax_x
  #--------------------------------------------------------------------------
  def calc_parallax_x(bitmap)
    if bitmap == nil
      return 0
    elsif @parallax_loop_x
      return @parallax_x / 16
    elsif loop_horizontal?
      return 0
    else
      w1 = bitmap.width - Graphics.width
      w2 = @map.width * 32 - Graphics.width
      if w1 <= 0 or w2 <= 0
        return 0
      else
        return @parallax_x * w1 / w2 / 8
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: calc_parallax_y
  #--------------------------------------------------------------------------
  def calc_parallax_y(bitmap)
    if bitmap == nil
      return 0
    elsif @parallax_loop_y
      return @parallax_y / 16
    elsif loop_vertical?
      return 0
    else
      h1 = bitmap.height - Graphics.height
      h2 = @map.height * 32 - Graphics.height
      if h1 <= 0 or h2 <= 0
        return 0
      else
        return @parallax_y * h1 / h2 / 8
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: scroll_down
  #--------------------------------------------------------------------------
  def scroll_down(distance)
    if loop_vertical?
      @display_y += distance
      @display_y %= @map.height * 256
      @parallax_y += distance
    else
      last_y = @display_y
      dh = Graphics.height > height * 32 ? height : (Graphics.height / 32)
      @display_y = [@display_y + distance, (height - dh) * 256].min
      @parallax_y += @display_y - last_y
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: scroll_right
  #--------------------------------------------------------------------------
  def scroll_right(distance)
    if loop_horizontal?
      @display_x += distance
      @display_x %= @map.width * 256
      @parallax_x += distance
    else
      last_x = @display_x
      dw = Graphics.width > width * 32 ? width : (Graphics.width / 32)
      @display_x = [@display_x + distance, (width - dw) * 256].min
      @parallax_x += @display_x - last_x
    end
  end
  
end # Game_Map

#==============================================================================
# Game_Player
#==============================================================================

class Game_Player < Game_Character
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias initialize_game_player_ce initialize unless $@
  def initialize
    initialize_game_player_ce
    @center_x = (Graphics.width / 2 - 16) * 8
    @center_y = (Graphics.height / 2 - 16) * 8
  end
  #--------------------------------------------------------------------------
  # overwrite method: center
  #--------------------------------------------------------------------------
  def center(x, y)
    display_x = x * 256 - @center_x
    unless $game_map.loop_horizontal?
      max_x = ($game_map.width - (Graphics.width / 32)) * 256
      display_x = [0, [display_x, max_x].min].max
    end
    display_y = y * 256 - @center_y
    unless $game_map.loop_vertical? 
      max_y = ($game_map.height - (Graphics.height / 32) ) * 256
      display_y = [0, [display_y, max_y].min].max 
    end
    $game_map.set_display_pos(display_x, display_y)
  end
  #--------------------------------------------------------------------------
  # Update Scroll (Rewrite)
  #--------------------------------------------------------------------------
  def update_scroll(last_real_x, last_real_y)
    ax1 = $game_map.adjust_x(last_real_x)
    ay1 = $game_map.adjust_y(last_real_y)
    ax2 = $game_map.adjust_x(@real_x)
    ay2 = $game_map.adjust_y(@real_y)
    if ay2 > ay1 and ay2 > @center_y
      $game_map.scroll_down(ay2 - ay1)
    end
    if ax2 < ax1 and ax2 < @center_x
      $game_map.scroll_left(ax1 - ax2)
    end
    if ax2 > ax1 and ax2 > @center_x
      $game_map.scroll_right(ax2 - ax1)
    end
    if ay2 < ay1 and ay2 < @center_y
      $game_map.scroll_up(ay1 - ay2)
    end
  end
  
end # Game_Player

#==============================================================================
# ** Game_Interpreter
#==============================================================================

class Game_Interpreter
  
  #--------------------------------------------------------------------------
  # overwrite method: command_122
  #--------------------------------------------------------------------------
  def command_122
    value = 0
    case @params[3]  # Operand
    when 0  # Constant
      value = @params[4]
    when 1  # Variable
      value = $game_variables[@params[4]]
    when 2  # Random
      value = @params[4] + rand(@params[5] - @params[4] + 1)
    when 3  # Item
      value = $game_party.item_number($data_items[@params[4]])
    when 4 # Actor
      actor = $game_actors[@params[4]]
      if actor != nil
        case @params[5]
        when 0  # Level
          value = actor.level
        when 1  # Experience
          value = actor.exp
        when 2  # HP
          value = actor.hp
        when 3  # MP
          value = actor.mp
        when 4  # Maximum HP
          value = actor.maxhp
        when 5  # Maximum MP
          value = actor.maxmp
        when 6  # Attack
          value = actor.atk
        when 7  # Defense
          value = actor.def
        when 8  # Spirit
          value = actor.spi
        when 9  # Agility
          value = actor.agi
        end
      end
    when 5  # Enemy
      enemy = $game_troop.members[@params[4]]
      if enemy != nil
        case @params[5]
        when 0  # HP
          value = enemy.hp
        when 1  # MP
          value = enemy.mp
        when 2  # Maximum HP
          value = enemy.maxhp
        when 3  # Maximum MP
          value = enemy.maxmp
        when 4  # Attack
          value = enemy.atk
        when 5  # Defense
          value = enemy.def
        when 6  # Spirit
          value = enemy.spi
        when 7  # Agility
          value = enemy.agi
        end
      end
    when 6  # Character
      character = get_character(@params[4])
      if character != nil
        case @params[5]
        when 0  # x-coordinate
          value = character.x
        when 1  # y-coordinate
          value = character.y
        when 2  # direction
          value = character.direction
        when 3  # screen x-coordinate
          value = character.screen_x
        when 4  # screen y-coordinate
          value = character.screen_y
        end
      end
    when 7  # Other
      case @params[4]
      when 0  # map ID
        value = $game_map.map_id
      when 1  # number of party members
        value = $game_party.members.size
      when 2  # gold
        value = $game_party.gold
      when 3  # steps
        value = $game_party.steps
      when 4  # play time
        value = Graphics.frame_count / Graphics.frame_rate
      when 5  # timer
        value = $game_system.timer / Graphics.frame_rate
      when 6  # save count
        value = $game_system.save_count
      end
    end
    for i in @params[0] .. @params[1]   # Batch control
      case @params[2]  # Operation
      when 0  # Set
        $game_variables[i] = value
      when 1  # Add
        $game_variables[i] += value
      when 2  # Sub
        $game_variables[i] -= value
      when 3  # Mul
        $game_variables[i] *= value
      when 4  # Div
        $game_variables[i] /= value if value != 0
      when 5  # Mod
        $game_variables[i] %= value if value != 0
      end
      if $game_variables[i] > 99999999    # Maximum limit check
        $game_variables[i] = 99999999
      end
      if $game_variables[i] < -99999999   # Minimum limit check
        $game_variables[i] = -99999999
      end
    end
    $game_map.need_refresh = true
    return true
  end
  
end # Game_Interpreter

#==============================================================================
# ** Sprite_Base
#==============================================================================

class Sprite_Base < Sprite
  
  # ***************************************************************************
  # CONSTANT RATE HAVE BEEN REMOVED TO USE Y6::SETTING::ANIMATION_RATE DIRECTLY
  # ***************************************************************************
  
  #--------------------------------------------------------------------------
  # overwrite method: update
  #--------------------------------------------------------------------------
  def update
    super
    update_animation if @animation != nil
    @@animations.clear
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: start_animation
  #--------------------------------------------------------------------------
  def start_animation(animation, mirror = false)
    dispose_animation
    @animation = animation
    return if @animation == nil
    @animation_mirror = mirror
    @animation_duration = @animation.frame_max * Y6::SETTING::ANIMATION_RATE + 1
    load_animation_bitmap
    @animation_sprites = []
    if @animation.position != 3 or not @@animations.include?(animation)
      if @use_sprite
        for i in 0..15
          sprite = ::Sprite.new(self.viewport)
          sprite.visible = false
          @animation_sprites.push(sprite)
        end
        @@animations.push(animation) unless @@animations.include?(animation)
      end
    end
    if @animation.position == 3
      if viewport == nil
        @animation_ox = Graphics.width / 2
        @animation_oy = Graphics.height / 2
      else
        @animation_ox = viewport.rect.width / 2
        @animation_oy = viewport.rect.height / 2
      end
    else
      @animation_ox = x - ox + width / 2
      @animation_oy = y - oy + height / 2
      if @animation.position == 0
        @animation_oy -= height / 2
      elsif @animation.position == 2
        @animation_oy += height / 2
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: start_pseudo_ani
  #--------------------------------------------------------------------------
  def start_pseudo_ani(animation, mirror = false)
    dispose_animation
    @animation = animation
    return if @animation == nil
    @animation_mirror = mirror
    @animation_duration = @animation.frame_max * Y6::SETTING::ANIMATION_RATE + 1
    @animation_sprites = []
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: update_animation
  #--------------------------------------------------------------------------
  def update_animation
    @animation_duration -= 1
    return unless @animation_duration % Y6::SETTING::ANIMATION_RATE == 0
    if @animation_duration > 0
      frame_index = @animation.frame_max
      frame_index -= (@animation_duration+Y6::SETTING::ANIMATION_RATE-1)/Y6::SETTING::ANIMATION_RATE
      animation_set_sprites(@animation.frames[frame_index])
      for timing in @animation.timings
        next unless timing.frame == frame_index
        animation_process_timing(timing)
      end
      return
    end
    dispose_animation
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: animation_process_timing
  #--------------------------------------------------------------------------
  def animation_process_timing(timing)
    timing.se.play
    case timing.flash_scope
    when 1
      self.flash(timing.flash_color, timing.flash_duration * Y6::SETTING::ANIMATION_RATE)
    when 2
      if viewport != nil
        viewport.flash(timing.flash_color, timing.flash_duration * Y6::SETTING::ANIMATION_RATE)
      end
    when 3
      self.flash(nil, timing.flash_duration * Y6::SETTING::ANIMATION_RATE)
    end
  end
  
end # Sprite_Base

#==============================================================================
# ** Sprite_Timer
#==============================================================================

class Sprite_Timer < Sprite
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias initialize_sprite_timer_ce initialize unless $@
  def initialize(viewport)
    initialize_sprite_timer_ce(viewport)
    self.x = Graphics.width - self.bitmap.width
  end
  
end # Sprite_Timer

#==============================================================================
# ** Spriteset_Map
#==============================================================================

class Spriteset_Map
  
  #--------------------------------------------------------------------------
  # overwrite method: create_viewports
  #--------------------------------------------------------------------------
  def create_viewports
    if Graphics.width > $game_map.width * 32 and !$game_map.loop_horizontal?
      dx = (Graphics.width - $game_map.width * 32) / 2
    else
      dx = 0
    end
    dw = [Graphics.width, $game_map.width * 32].min
    dw = Graphics.width if $game_map.loop_horizontal?
    if Graphics.height > $game_map.height * 32 and !$game_map.loop_vertical?
      dy = (Graphics.height - $game_map.height * 32) / 2
    else
      dy = 0
    end
    dh = [Graphics.height, $game_map.height * 32].min
    dh = Graphics.height if $game_map.loop_vertical?
    @viewport1 = Viewport.new(dx, dy, dw, dh)
    @viewport2 = Viewport.new(dx, dy, dw, dh)
    @viewport3 = Viewport.new(dx, dy, dw, dh)
    @viewport2.z = 50
    @viewport3.z = 100
  end
  
end # Spriteset_Map

#==============================================================================
# ** Spriteset_Battle
#==============================================================================

class Spriteset_Battle
  
  #--------------------------------------------------------------------------
  # overwrite method: create_viewports
  #--------------------------------------------------------------------------
  def create_viewports
    @viewport1 = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport2 = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport3 = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport2.z = 50
    @viewport3.z = 100
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: create_battleback
  #--------------------------------------------------------------------------
  def create_battleback
    source = $game_temp.background_bitmap
    bitmap = Bitmap.new(Graphics.width + 96, Graphics.height + 64)
    bitmap.stretch_blt(bitmap.rect, source, source.rect)
    bitmap.radial_blur(90, 12)
    @battleback_sprite = Sprite.new(@viewport1)
    @battleback_sprite.bitmap = bitmap
    @battleback_sprite.ox = (Graphics.width + 96) / 2
    @battleback_sprite.oy = (Graphics.height + 64) / 2
    @battleback_sprite.x = Graphics.width / 2
    @battleback_sprite.y = (Graphics.height - 64) / 2
    @battleback_sprite.wave_amp = 8
    @battleback_sprite.wave_length = 240
    @battleback_sprite.wave_speed = 120
  end
  
  #--------------------------------------------------------------------------
  # alias method: create_battlefloor
  #--------------------------------------------------------------------------
  alias create_battlefloor_ce create_battlefloor unless $@
  def create_battlefloor
    create_battlefloor_ce
    @battlefloor_sprite.x = (Graphics.width - 544) / 2
    @battlefloor_sprite.y = 192 + (Graphics.height - 416) / 2
  end
  
end # Spriteset_Battle

#==============================================================================
# ** Window_Base
#==============================================================================

class Window_Base < Window
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias initialize_window_base_ce initialize unless $@
  def initialize(x, y, width, height)
    initialize_window_base_ce(x, y, width, height)
    contents.font.color = normal_color
    if $game_temp.in_battle
      $disposable_battle_windows = [] if $disposable_battle_windows == nil
      $disposable_battle_windows.push(self)
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: dispose
  #--------------------------------------------------------------------------
  def dispose
    if $game_temp.in_battle
      $disposable_battle_windows = [] if $disposable_battle_windows == nil
      $disposable_battle_windows.delete(self)
    end
    if self.disposed?
      if $TEST or $BTEST
        p "Failure to dispose Nil window."
        p self
      end
    else
      contents.dispose
    end
    super
  end
  
  #--------------------------------------------------------------------------
  # alias method: create_contents
  #--------------------------------------------------------------------------
  alias create_contents_base_ce create_contents unless $@
  def create_contents
    create_contents_base_ce
    contents.font.color = normal_color
  end
  
  #--------------------------------------------------------------------------
  # overwrite methods: *_colors
  #--------------------------------------------------------------------------
  def normal_color; return text_color(Y6::SETTING::COLOURS[:normal]); end
  def system_color; return text_color(Y6::SETTING::COLOURS[:system]); end
  def crisis_color; return text_color(Y6::SETTING::COLOURS[:crisis]); end
  def lowmp_color; return text_color(Y6::SETTING::COLOURS[:lowmp]); end
  def knockout_color; return text_color(Y6::SETTING::COLOURS[:knockout]); end
  def gauge_back_color; return text_color(Y6::SETTING::COLOURS[:gaugeback]); end
  def exhaust_color; return text_color(Y6::SETTING::COLOURS[:exhaust]); end
  def hp_back_color; return text_color(Y6::SETTING::COLOURS[:hp_back]); end
  def hp_gauge_color1; return text_color(Y6::SETTING::COLOURS[:hp_gauge1]); end
  def hp_gauge_color2; return text_color(Y6::SETTING::COLOURS[:hp_gauge2]); end
  def mp_back_color; return text_color(Y6::SETTING::COLOURS[:mp_back]); end
  def mp_gauge_color1; return text_color(Y6::SETTING::COLOURS[:mp_gauge1]); end
  def mp_gauge_color2; return text_color(Y6::SETTING::COLOURS[:mp_gauge2]); end
  def power_up_color; return text_color(Y6::SETTING::COLOURS[:power_up]); end
  def power_down_color; return text_color(Y6::SETTING::COLOURS[:power_dn]); end
    
  #--------------------------------------------------------------------------
  # overwrite method: hp_color
  #--------------------------------------------------------------------------
  def hp_color(actor)
    return knockout_color if actor.hp == 0
    return crisis_color if actor.hp < (actor.maxhp*Y6::SETTING::CRISIS_HP/100)
    return normal_color
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: mp_color
  #--------------------------------------------------------------------------
  def mp_color(actor)
    return lowmp_color if actor.mp < (actor.maxmp*Y6::SETTING::CRISIS_MP/100)
    return normal_color
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_actor_hp_gauge
  #--------------------------------------------------------------------------
  def draw_actor_hp_gauge(actor, x, y, width = 120)
    actor.hp = [actor.hp, actor.maxhp].min
    gc0 = hp_back_color
    gc1 = hp_gauge_color1
    gc2 = hp_gauge_color2
    gh = Y6::SETTING::GAUGE_HEIGHT
    gh += 2 if Y6::SETTING::OUTLINE
    gy = y + WLH - 8 - (gh - 6)
    contents.fill_rect(x, gy, width, gh, gc0)
    gy += 1 if Y6::SETTING::OUTLINE
    gh -= 2 if Y6::SETTING::OUTLINE
    width -= 2 if Y6::SETTING::OUTLINE
    maxhp = [[actor.maxhp, actor.base_maxhp, 1].max, actor.maxhp_limit].min
    gbw = width * actor.hp / maxhp
    x += 1 if Y6::SETTING::OUTLINE
    contents.gradient_fill_rect(x, gy, gbw, gh, gc1, gc2)
    return unless maxhp > actor.maxhp
    dw = width * (actor.base_maxhp - actor.maxhp) / actor.base_maxhp
    dx = x + width - dw
    contents.fill_rect(dx, gy, dw, gh, exhaust_color)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_actor_mp_gauge
  #--------------------------------------------------------------------------
  def draw_actor_mp_gauge(actor, x, y, width = 120, height = nil)
    actor.mp = [actor.mp, actor.maxmp].min
    gc0 = mp_back_color
    gc1 = mp_gauge_color1
    gc2 = mp_gauge_color2
    gh = Y6::SETTING::GAUGE_HEIGHT
    gh += 2 if Y6::SETTING::OUTLINE
    gy = y + WLH - 8 - (gh - 6)
    contents.fill_rect(x, gy, width, gh, gc0)
    gy += 1 if Y6::SETTING::OUTLINE
    gh -= 2 if Y6::SETTING::OUTLINE
    width -= 2 if Y6::SETTING::OUTLINE
    maxmp = [[actor.maxmp, actor.base_maxmp, 1].max, actor.maxmp_limit].min
    gbw = width * actor.mp / maxmp
    x += 1 if Y6::SETTING::OUTLINE
    contents.gradient_fill_rect(x, gy, gbw, gh, gc1, gc2)
    return unless maxmp > actor.maxmp
    dw = width * (actor.base_maxmp - actor.maxmp) / [actor.base_maxmp, 1].max
    dx = x + width - dw
    contents.fill_rect(dx, gy, dw, gh, exhaust_color)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_actor_level
  #--------------------------------------------------------------------------
  def draw_actor_level(actor, x, y)
    contents.font.color = system_color
    dw1 = contents.text_size(Vocab::level_a + " ").width
    contents.draw_text(x, y, dw1, WLH, Vocab::level_a)
    contents.font.color = normal_color
    dw2 = contents.text_size(actor.level_limit.group).width
    contents.draw_text(x + dw1, y, dw2, WLH, actor.level.group, 2)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_actor_hp
  #--------------------------------------------------------------------------
  def draw_actor_hp(actor, x, y, width = 120)
    draw_actor_hp_gauge(actor, x, y, width)
    contents.font.color = system_color
    contents.draw_text(x+2, y, 30, WLH, Vocab::hp_a)
    contents.font.color = hp_color(actor)
    last_font_size = contents.font.size
    text = sprintf("%s/%s", actor.hp.group, actor.maxhp.group)
    if width-33 < contents.text_size(text).width
      contents.draw_text(x+32, y, width-33, WLH, actor.hp.group, 1)
    else
      contents.draw_text(x+32, y, width-33, WLH, text, 1)
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_actor_mp
  #--------------------------------------------------------------------------
  def draw_actor_mp(actor, x, y, width = 120)
    draw_actor_mp_gauge(actor, x, y, width)
    contents.font.color = system_color
    contents.draw_text(x+2, y, 30, WLH, Vocab::mp_a)
    contents.font.color = mp_color(actor)
    last_font_size = contents.font.size
    text = sprintf("%s/%s", actor.mp.group, actor.maxmp.group)
    if width-33 < contents.text_size(text).width
      contents.draw_text(x+32, y, width-33, WLH, actor.mp.group, 1)
    else
      contents.draw_text(x+32, y, width-33, WLH, text, 1)
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_actor_parameter
  #--------------------------------------------------------------------------
  def draw_actor_parameter(actor, x, y, type)
    case type
    when 0
      parameter_name = Vocab::atk
      parameter_value = actor.atk
    when 1
      parameter_name = Vocab::def
      parameter_value = actor.def
    when 2
      parameter_name = Vocab::spi
      parameter_value = actor.spi
    when 3
      parameter_name = Vocab::agi
      parameter_value = actor.agi
    end
    contents.font.color = system_color
    contents.draw_text(x, y, 120, WLH, parameter_name)
    contents.font.color = normal_color
    contents.draw_text(x + 120, y, 36, WLH, parameter_value.group, 2)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_actor_state
  #--------------------------------------------------------------------------
  def draw_actor_state(actor, x, y, width = 96)
    count = 0
    for state in actor.states
      next if state.icon_index == 0
      next if state.hide_state
      draw_icon(state.icon_index, x + 24 * count, y)
      draw_state_turns(x + 24 * count, y, state, actor)
      count += 1
      break if (24 * count > width - 24)
    end
    contents.font.color = normal_color
    contents.font.bold = Font.default_bold
    contents.font.size = Font.default_size
  end
  
  #--------------------------------------------------------------------------
  # new method: draw_state_turns
  #--------------------------------------------------------------------------
  def draw_state_turns(x, y, state, actor)
    return unless Y6::SETTING::DRAW_STATE_TURNS
    return if state == nil
    return unless actor.state_turns.include?(state.id)
    dy = y - (Y6::SETTING::STATE_TURN_F_SIZE - 10)
    duration = actor.state_turns[state.id] 
    if state.auto_release_prob > 0 and duration >= 0
      contents.font.color = text_color(state.turn_colour)
      contents.font.size = Y6::SETTING::STATE_TURN_F_SIZE
      contents.font.bold = Y6::SETTING::STATE_TURN_BOLD
      contents.draw_text(x, dy, 24, WLH, duration, 2)
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_currency_value
  #--------------------------------------------------------------------------
  def draw_currency_value(value, x, y, width)
    cx = contents.text_size(Vocab::gold).width
    contents.font.color = normal_color
    contents.draw_text(x, y, width-cx-2, WLH, value.group, 2)
    contents.font.color = system_color
    contents.draw_text(x, y, width, WLH, Vocab::gold, 2)
  end
  
end # Window_Base

#==============================================================================
# ** Window_Selectable
#==============================================================================

class Window_Selectable < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: create_contents
  #--------------------------------------------------------------------------
  def create_contents
    contents.dispose
    maxbitmap = 8192
    dw = [width - 32, maxbitmap].min
    dh = [[height - 32, row_max * WLH].max, maxbitmap].min
    bitmap = Bitmap.new(dw, dh)
    self.contents = bitmap
    contents.font.color = normal_color
  end
  
end # Window_Selectable

#==============================================================================
# ** Window_Command_Centered
#==============================================================================

class Window_Command_Centered < Window_Command
  
  #--------------------------------------------------------------------------
  # draw_item
  #--------------------------------------------------------------------------
  def draw_item(index, enabled = true)
    rect = item_rect(index)
    rect.x += 4
    rect.width -= 8
    contents.clear_rect(rect)
    contents.font.color = normal_color
    contents.font.color.alpha = enabled ? 255 : 128
    contents.draw_text(rect, @commands[index], 1)
  end
  
end # Window_Command_Centered

#==============================================================================
# ** Window_Help
#==============================================================================

class Window_Help < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, Graphics.width, WLH + 32)
  end
  
  #--------------------------------------------------------------------------
  # alias method: set_text
  #--------------------------------------------------------------------------
  alias set_text_ce set_text unless $@
  def set_text(text, align = 0)
    text = text.clone
    text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    text.gsub!(/\\N\[0\]/i)        { current_actor }
    text.gsub!(/\\N\[([0-9]+)\]/i) { $game_actors[$1.to_i].name }
    set_text_ce(text, align)
  end
  
  #--------------------------------------------------------------------------
  # new method: current_actor
  #--------------------------------------------------------------------------
  def current_actor
    if $scene.is_a?(Scene_Skill) or $scene.is_a?(Scene_Equip)
      return $scene.actor.name
    elsif $scene.is_a?(Scene_Battle) and $scene.active_battler != nil
      return $scene.active_battler.name
    else
      return Y6::SETTING::HELP_WINDOW_0
    end
  end
  
end # Window_Help

#==============================================================================
# ** Window_MenuStatus
#==============================================================================

class Window_MenuStatus < Window_Selectable
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(x, y)
    super(x, y, Graphics.width - 160, Graphics.height)
    refresh
    self.active = false
    self.index = -1
  end
  
  #--------------------------------------------------------------------------
  # Refresh (Rewrite)
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
    @item_max = $game_party.members.size
    for actor in $game_party.members
      y = (Graphics.height-32)/4 > 96 ? ((Graphics.height-32)/4-96)/2+2 : 2
      draw_actor_face(actor, 2, actor.index * (Graphics.height-32)/4 + y, 92)
      x = 104
      y = actor.index * (Graphics.height-32)/4 + WLH / 2
      y += ((Graphics.height-32)/4 - 96) / 2 if (Graphics.height-32)/4 > 96
      draw_actor_name(actor, x, y)
      draw_actor_class(actor, x + 120, y)
      draw_actor_level(actor, x, y + WLH * 1)
      draw_actor_state(actor, x, y + WLH * 2)
      bar_width = contents.width - x - 124
      draw_actor_hp(actor, x + 120, y + WLH * 1, bar_width)
      draw_actor_mp(actor, x + 120, y + WLH * 2, bar_width)
    end
  end
  
  #--------------------------------------------------------------------------
  # Update cursor (Rewrite)
  #--------------------------------------------------------------------------
  def update_cursor
    if @index < 0
      self.cursor_rect.empty
    elsif @index < @item_max
      self.cursor_rect.set(0, @index * (Graphics.height-32)/4, contents.width,
        (Graphics.height-32)/4)
    elsif @index >= 100
      self.cursor_rect.set(0, (@index - 100) * (Graphics.height-32)/4,
        contents.width, (Graphics.height-32)/4)
    else
      self.cursor_rect.set(0, 0, contents.width, 
        @item_max * (Graphics.height-32)/4)
    end
  end
  
end # Window_MenuStatus

#==============================================================================
# ** Window_Item
#==============================================================================

class Window_Item < Window_Selectable
  
  #--------------------------------------------------------------------------
  # overwrite method: include
  #--------------------------------------------------------------------------
  def include?(item)
    return false if item == nil
    return false if $game_temp.in_battle and !$game_party.item_can_use?(item)
    return true
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_item
  #--------------------------------------------------------------------------
  def draw_item(index)
    rect = item_rect(index)
    contents.clear_rect(rect)
    item = @data[index]
    if item != nil
      number = $game_party.item_number(item)
      enabled = enable?(item)
      rect.width -= 4
      draw_item_name(item, rect.x, rect.y, enabled)
      contents.draw_text(rect, sprintf("??%2d", number.group), 2)
    end
  end
  
end # Window_Item

#==============================================================================
# ** Window_Skill
#==============================================================================

class Window_Skill < Window_Selectable
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_item
  #--------------------------------------------------------------------------
  def draw_item(index)
    rect = item_rect(index)
    contents.clear_rect(rect)
    skill = @data[index]
    if skill != nil
      rect.width -= 4
      enabled = @actor.skill_can_use?(skill)
      draw_item_name(skill, rect.x, rect.y, enabled)
      contents.draw_text(rect, @actor.calc_mp_cost(skill).group, 2)
    end
  end
  
end # Window_Skill

#==============================================================================
# ** Window_SkillStatus
#==============================================================================

class Window_SkillStatus < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(x, y, actor)
    super(x, y, Graphics.width, WLH + 32)
    @actor = actor
    refresh
  end
  
end # Window_SkillStatus

#==============================================================================
# ** Window_Equip
#==============================================================================

class Window_Equip < Window_Selectable
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(x, y, actor)
    super(x, y, Graphics.width - 208, WLH * 5 + 32)
    @actor = actor
    refresh
    self.index = 0
  end
  
end # Window_Equip

#==============================================================================
# ** Window_EquipStatus
#==============================================================================

class Window_EquipStatus < Window_Base
  
  #--------------------------------------------------------------------------
  # * Draw Parameters
  #--------------------------------------------------------------------------
  def draw_parameter(x, y, type)
    case type
    when 0
      name = Vocab::atk
      value = @actor.atk
      new_value = @new_atk
    when 1
      name = Vocab::def
      value = @actor.def
      new_value = @new_def
    when 2
      name = Vocab::spi
      value = @actor.spi
      new_value = @new_spi
    when 3
      name = Vocab::agi
      value = @actor.agi
      new_value = @new_agi
    end
    contents.font.color = system_color
    contents.draw_text(x + 4, y, 80, WLH, name)
    contents.font.color = normal_color
    contents.draw_text(x + 90, y, 30, WLH, value.group, 2)
    contents.font.color = system_color
    contents.draw_text(x + 122, y, 20, WLH, ">", 1)
    if new_value != nil
      contents.font.color = new_parameter_color(value , new_value)
      contents.draw_text(x + 142, y, 30, WLH, new_value.group, 2)
    end
  end
  
end # Window_EquipStatus

#==============================================================================
# Window_Status
#==============================================================================

class Window_Status < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(actor)
    super(0, 0, Graphics.width, Graphics.height)
    @actor = actor
    refresh
  end
  
end # Window_Status

#==============================================================================
# ** Window_SaveFile
#==============================================================================

class Window_SaveFile < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(file_index, filename)
    dh = (Graphics.height - 56) / 4
    super(0, 56 + file_index % 4 * dh, Graphics.width, dh)
    @file_index = file_index
    @filename = filename
    load_gamedata
    refresh
    @selected = false
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_playtime
  #--------------------------------------------------------------------------
  def draw_playtime(x, y, width, align)
    hour = @total_sec / 60 / 60
    min = @total_sec / 60 % 60
    sec = @total_sec % 60
    time_string = sprintf("%s:%02d:%02d", hour.group, min, sec)
    contents.font.color = normal_color
    contents.draw_text(x, y, width, WLH, time_string, 2)
  end
  
end # Window_SaveFile

#==============================================================================
# ** Window_ShopBuy
#==============================================================================

class Window_ShopBuy < Window_Selectable
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(x, y)
    super(x, y, 304, Graphics.height - y)
    @shop_goods = $game_temp.shop_goods
    refresh
    self.index = 0
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_item
  #--------------------------------------------------------------------------
  def draw_item(index)
    item = @data[index]
    number = $game_party.item_number(item)
    enabled = (item.price <= $game_party.gold and number < 99)
    rect = item_rect(index)
    contents.clear_rect(rect)
    draw_item_name(item, rect.x, rect.y, enabled)
    rect.width -= 4
    contents.draw_text(rect, item.price.group, 2)
  end
  
end # Window_ShopBuy

#==============================================================================
# ** Window_ShopNumber
#==============================================================================

class Window_ShopNumber < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(x, y)
    super(x, y, 304, Graphics.height - y)
    @item = nil
    @max = 1
    @price = 0
    @number = 1
  end
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    y = (contents.height - WLH*5)/2
    contents.clear
    draw_item_name(@item, 0, y)
    contents.font.color = normal_color
    text = sprintf("??%s", @number.group)
    cx = contents.text_size(text).width
    contents.draw_text(contents.width-cx-4, y, cx, WLH, text, 2)
    self.cursor_rect.set(contents.width-cx-4, y, cx+4, WLH)
    draw_currency_value($game_party.gold, 4, y+WLH*2, contents.width-8)
    dw = contents.width-8
    if Y6::SETTING::OUTLINE
      contents.fill_rect(3, y+WLH*4-5, dw, 3, gauge_back_color)
      contents.fill_rect(4, y+WLH*4-4, dw-2, 1, normal_color)
    else
      contents.fill_rect(5, y+WLH*4-3, dw, 1, gauge_back_color)
      contents.fill_rect(4, y+WLH*4-4, dw, 1, normal_color)
    end
    case $scene.command_window.index
    when 0
      dn = @price * @number * -1
      draw_currency_value(dn, 4, y+WLH*3, contents.width-8)
      new_total = $game_party.gold + dn
      draw_currency_value(new_total, 4, y+WLH*4, contents.width-8)
    else
      dn = @price * @number
      draw_currency_value(dn, 4, y+WLH*3, contents.width-8)
      new_total = $game_party.gold + dn
      draw_currency_value(new_total, 4, y+WLH*4, contents.width-8)
    end
  end
  
end # Window_ShopNumber

#==============================================================================
# ** Window_ShopStatus
#==============================================================================

class Window_ShopStatus < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(x, y)
    super(x, y, Graphics.width - 304, Graphics.height - y)
    @item = nil
    refresh
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: refresh
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
    if @item != nil
      number = $game_party.item_number(@item)
      contents.font.color = system_color
      text = Vocab::Possession
      contents.draw_text(4, 0, contents.width-8, WLH, text)
      contents.font.color = normal_color
      contents.draw_text(4, 0, contents.width-8, WLH, number.group, 2)
      for actor in $game_party.members
        x = 4
        y = WLH * (2 + actor.index * 2)
        draw_actor_parameter_change(actor, x, y)
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_actor_parameter_change
  #--------------------------------------------------------------------------
  def draw_actor_parameter_change(actor, x, y)
    return if @item.is_a?(RPG::Item)
    enabled = actor.equippable?(@item)
    contents.font.color = normal_color
    contents.font.color.alpha = enabled ? 255 : 128
    contents.draw_text(x, y, 200, WLH, actor.name)
    if @item.is_a?(RPG::Weapon)
      item1 = weaker_weapon(actor)
    elsif actor.two_swords_style and @item.kind == 0
      item1 = nil
    else
      item1 = actor.equips[1 + @item.kind]
    end
    if enabled
      if @item.is_a?(RPG::Weapon)
        atk1 = item1 == nil ? 0 : item1.atk
        atk2 = @item == nil ? 0 : @item.atk
        change = atk2 - atk1
      else
        def1 = item1 == nil ? 0 : item1.def
        def2 = @item == nil ? 0 : @item.def
        change = def2 - def1
      end
      if change > 0
        string = "+" + change.group
      elsif change < 0
        string = change.group
      else
        string = ""
      end
      contents.draw_text(x, y, contents.width-4, WLH, string, 2)
    end
    draw_item_name(item1, x, y + WLH, enabled)
  end
  
end # Window_ShopStatus

#==============================================================================
# ** Window_NameEdit
#==============================================================================

class Window_NameEdit < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(actor, max_char)
    super((Graphics.width - 368) / 2, (Graphics.height - 376) / 2, 368, 128)
    @actor = actor
    @name = actor.name
    @max_char = max_char
    name_array = @name.split(//)[0...@max_char]
    @name = ""
    for i in 0...name_array.size
      @name += name_array[i]
    end
    @default_name = @name
    @index = name_array.size
    self.active = false
    refresh
    update_cursor
  end
  
end # Window_NameEdit

#==============================================================================
# ** Window_NameInput
#==============================================================================

class Window_NameInput < Window_Base
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(mode = 0)
    super((Graphics.width-368)/2, ((Graphics.height-376)/2) + 128, 368, 248)
    @mode = mode
    @index = 0
    refresh
    update_cursor
  end
  
end # Window_NameInput

#==============================================================================
# ** Window_NumberInput
#==============================================================================

class Window_NumberInput < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, Graphics.width, 64)
    @number = 0
    @digits_max = 6
    @index = 0
    self.opacity = 0
    self.active = false
    self.z += 9999
    refresh
    update_cursor
  end
  
end # Window_NumberInput

#==============================================================================
# ** Window_Message
#==============================================================================

class Window_Message < Window_Selectable
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    y = $game_temp.in_battle ? (Graphics.height - 128) : 288
    super(0, y, Graphics.width, 128)
    self.z = 200
    self.active = false
    self.index = -1
    self.openness = 0
    @opening = false
    @closing = false
    @text = nil
    @contents_x = 0
    @contents_y = 0
    @line_count = 0
    @wait_count = 0
    @background = 0
    @position = 2
    @show_fast = false
    @line_show_fast = false
    @pause_skip = false
    create_gold_window
    create_number_input_window
    create_back_sprite
  end
  
  #--------------------------------------------------------------------------
  # alias method: create_gold_window
  #--------------------------------------------------------------------------
  alias create_gold_window_window_message_ce create_gold_window unless $@
  def create_gold_window
    create_gold_window_window_message_ce
    @gold_window.x = Graphics.width - 160
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: reset_window
  #--------------------------------------------------------------------------
  def reset_window
    @background = $game_message.background
    @position = $game_message.position
    if @background == 0
      self.opacity = 255
    else 
      self.opacity = 0
    end
    case @position
    when 0  # Top
      self.y = 0
      @gold_window.y = Graphics.height - 56
    when 1  # Middle
      self.y = (Graphics.height / 2) - self.height / 2
      @gold_window.y = 0
    when 2  # Bottom
      self.y = Graphics.height - self.height
      @gold_window.y = 0
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: convert_special_characters
  #--------------------------------------------------------------------------
  alias convert_special_characters_ce convert_special_characters unless $@
  def convert_special_characters
    @text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    @text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    @text.gsub!(/\\N\[0\]/i)        { $game_party.members[0].name }
    @text.gsub!(/\\F\[0\]/i)        { leader_face_art }
    convert_special_characters_ce
  end
  
  #--------------------------------------------------------------------------
  # new method: leader_face_art
  #--------------------------------------------------------------------------
  def leader_face_art
    $game_message.face_name  = $game_party.members[0].face_name
    $game_message.face_index = $game_party.members[0].face_index
    return ""
  end
  
end # Window_Message

#==============================================================================
# ** Window_BattleStatus
#==============================================================================

class Window_BattleStatus < Window_Selectable
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, Graphics.width-128, 128)
    refresh
    self.active = false
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_item
  #--------------------------------------------------------------------------
  def draw_item(index)
    rect = item_rect(index)
    rect.x += 4
    rect.width -= 8
    contents.clear_rect(rect)
    contents.font.color = normal_color
    actor = $game_party.members[index]
    draw_actor_name(actor, 4, rect.y)
    draw_actor_state(actor, 114, rect.y, 48)
    remaining_width = contents.width - 174
    hp_width = remaining_width * 2 / 3
    mp_width = remaining_width - hp_width - 8
    draw_actor_hp(actor, 174, rect.y, hp_width)
    draw_actor_mp(actor, 180 + hp_width, rect.y, mp_width)
  end
  
end # Window_BattleStatus

#==============================================================================
# ** Window_DebugLeft
#==============================================================================

class Window_DebugLeft < Window_Selectable
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(x, y)
    super(x, y, 176, Graphics.height)
    self.index = 0
    refresh
  end
  
end # Window_DebugLeft

#==============================================================================
# ** Window_DebugRight
#==============================================================================

class Window_DebugRight < Window_Selectable
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  def initialize(x, y)
    super(x, y, Graphics.width - x, 10 * WLH + 32)
    self.index = -1
    self.active = false
    @item_max = 10
    @mode = 0
    @top_id = 1
    refresh
  end
  
end # Window_DebugRight

#==============================================================================
# ** Scene_Title
#==============================================================================

class Scene_Title < Scene_Base
  
  #--------------------------------------------------------------------------
  # alias method: main
  #--------------------------------------------------------------------------
  alias main_ce main unless $@
  def main
    resize_screen
    main_ce
  end
  
  #--------------------------------------------------------------------------
  # new method: resize_screen
  #--------------------------------------------------------------------------
  def resize_screen
    if Y6::SETTING::RESIZE_WIDTH == 544 and Y6::SETTING::RESIZE_HEIGHT == 416
      return
    end
    width = Y6::SETTING::RESIZE_WIDTH
    height = Y6::SETTING::RESIZE_HEIGHT
    Graphics.resize_screen(width, height)
  end
  
  #--------------------------------------------------------------------------
  # alias method: create_title_graphic
  #--------------------------------------------------------------------------
  alias create_title_graphic_ce create_title_graphic unless $@
  def create_title_graphic
    create_title_graphic_ce
    @sprite.x = (Graphics.width - @sprite.bitmap.width)/2
    @sprite.y = (Graphics.height - @sprite.bitmap.height)/2
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: create_command_window
  #--------------------------------------------------------------------------
  def create_command_window
    commands = [Vocab::new_game, Vocab::continue, Vocab::shutdown]
    @data = []
    @command_window = Window_Command_Centered.new(172, commands)
    @command_window.x = (Graphics.width - @command_window.width) / 2
    @command_window.y = Graphics.height - @command_window.height - 24
    if @continue_enabled
      @command_window.index = 1
    else
      @command_window.draw_item(1, false)
    end
    @command_window.openness = 0
    @command_window.open
  end
  
end # Scene_Title

#==============================================================================
# ** Scene_Menu
#==============================================================================

class Scene_Menu < Scene_Base
  
  #--------------------------------------------------------------------------
  # alias method: start
  #--------------------------------------------------------------------------
  alias start_scene_menu_ce start unless $@
  def start
    start_scene_menu_ce
    @gold_window.y = Graphics.height - @gold_window.height
  end
  
  #--------------------------------------------------------------------------
  # alias method: end_actor_selection
  #--------------------------------------------------------------------------
  alias end_actor_selection_ce end_actor_selection unless $@
  def end_actor_selection
    $game_party.last_actor_index = @status_window.index
    end_actor_selection_ce
  end
  
end # Scene_Menu

#==============================================================================
# ** Scene_Item
#==============================================================================

class Scene_Item < Scene_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: start
  #--------------------------------------------------------------------------
  def start
    super
    create_menu_background
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @help_window = Window_Help.new
    @help_window.viewport = @viewport
    @item_window = Window_Item.new(0, 56, Graphics.width, Graphics.height - 56)
    @item_window.viewport = @viewport
    @item_window.help_window = @help_window
    @item_window.active = false
    @target_window = Window_MenuStatus.new(0, 0)
    hide_target_window
  end
  
  #--------------------------------------------------------------------------
  # alias method: show_target_window
  #--------------------------------------------------------------------------
  alias show_target_window_scene_item_ce show_target_window unless $@
  def show_target_window(right)
    show_target_window_scene_item_ce(right)
    width_remain = Graphics.width - @target_window.width
    @target_window.x = width_remain if right
    x = right ? 0 : @target_window.width
    @viewport.rect.set(x, 0, width_remain, Graphics.height)
  end
  
  #--------------------------------------------------------------------------
  # alias method: hide_target_window
  #--------------------------------------------------------------------------
  alias hide_target_window_scene_item_ce hide_target_window unless $@
  def hide_target_window
    hide_target_window_scene_item_ce
    @viewport.rect.set(0, 0, Graphics.width, Graphics.height)
  end
  
end # Scene_Item

#==============================================================================
# ** Scene_Skill
#==============================================================================

class Scene_Skill < Scene_Base
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :actor
    
  #--------------------------------------------------------------------------
  # overwrite method: start
  #--------------------------------------------------------------------------
  def start
    super
    create_menu_background
    @actor = $game_party.members[@actor_index]
    $game_party.last_actor_index = @actor_index
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @help_window = Window_Help.new
    @help_window.viewport = @viewport
    @status_window = Window_SkillStatus.new(0, 56, @actor)
    @status_window.viewport = @viewport
    @skill_window = Window_Skill.new(0, 112, Graphics.width,
      Graphics.height - @help_window.height - @status_window.height, @actor)
    @skill_window.viewport = @viewport
    @skill_window.help_window = @help_window
    @target_window = Window_MenuStatus.new(0, 0)
    hide_target_window
  end
  
  #--------------------------------------------------------------------------
  # alias method: update_skill_selection
  #--------------------------------------------------------------------------
  alias update_skill_selection_ce update_skill_selection unless $@
  def update_skill_selection
    if (Input.trigger?(Input::L) or Input.trigger?(Input::R)) and
    @actor.skills.size > Y6::SETTING::SKILL_LIST_SIZE
      return
    end
    update_skill_selection_ce
  end
  
  #--------------------------------------------------------------------------
  # alias method: show_target_window
  #--------------------------------------------------------------------------
  alias show_target_window_scene_skill_ce show_target_window unless $@
  def show_target_window(right)
    show_target_window_scene_skill_ce(right)
    width_remain = Graphics.width - @target_window.width
    @target_window.x = width_remain if right
    x = right ? 0 : @target_window.width
    @viewport.rect.set(x, 0, width_remain, Graphics.height)
  end
  
  #--------------------------------------------------------------------------
  # Hide Target Window (Mod)
  #--------------------------------------------------------------------------
  alias hide_target_window_scene_skill_ce hide_target_window unless $@
  def hide_target_window
    hide_target_window_scene_skill_ce
    @viewport.rect.set(0, 0, Graphics.width, Graphics.height)
  end
  
end # Scene_Skill

#==============================================================================
# ** Scene_Equip
#==============================================================================

class Scene_Equip < Scene_Base
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :actor
  
  #--------------------------------------------------------------------------
  # alias method: start
  #--------------------------------------------------------------------------
  alias start_scene_equip_ce start unless $@
  def start
    start_scene_equip_ce
    $game_party.last_actor_index = @actor_index
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: create_item_windows
  #--------------------------------------------------------------------------
  def create_item_windows
    @item_windows = []
    for i in 0...EQUIP_TYPE_MAX
      @item_windows[i] = Window_EquipItem.new(0, 208, Graphics.width, 
        Graphics.height - 208, @actor, i)
      @item_windows[i].help_window = @help_window
      @item_windows[i].visible = (@equip_index == i)
      @item_windows[i].active = false
      @item_windows[i].index = -1
    end
  end
  
end # Scene_Equip

#==============================================================================
# ** Scene_Status
#==============================================================================

class Scene_Status < Scene_Base
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :actor
  
  #--------------------------------------------------------------------------
  # alias method: start
  #--------------------------------------------------------------------------
  alias start_scene_status_ce start unless $@
  def start
    start_scene_status_ce
    $game_party.last_actor_index = @actor_index
  end
  
end # Scene_Skill

#==============================================================================
# ** Scene_End
#==============================================================================

class Scene_End < Scene_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: create_command_window
  #--------------------------------------------------------------------------
  def create_command_window
    commands = [Vocab::to_title, Vocab::shutdown, Vocab::cancel]
    @command_window = Window_Command_Centered.new(172, commands)
    @command_window.x = (Graphics.width - @command_window.width) / 2
    @command_window.y = (Graphics.height - @command_window.height) / 2
    @command_window.openness = 0
  end
  
end # Scene_End

#==============================================================================
# ** Scene_Shop
#==============================================================================

class Scene_Shop < Scene_Base
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :command_window
  
  #--------------------------------------------------------------------------
  # overwrite method: start
  #--------------------------------------------------------------------------
  def start
    super
    create_menu_background
    create_command_window
    @help_window = Window_Help.new
    @gold_window = Window_Gold.new(Graphics.width - 160, @help_window.height)
    @dummy_window = Window_Base.new(0, 112, Graphics.width,
      Graphics.height - @help_window.height * 2)
    @buy_window = Window_ShopBuy.new(0, 112)
    @buy_window.active = false
    @buy_window.visible = false
    @buy_window.help_window = @help_window
    @sell_window = Window_ShopSell.new(0, 112, Graphics.width,
      Graphics.height - @help_window.height * 2)
    @sell_window.active = false
    @sell_window.visible = false
    @sell_window.help_window = @help_window
    @number_window = Window_ShopNumber.new(0, 112)
    @number_window.active = false
    @number_window.visible = false
    @status_window = Window_ShopStatus.new(304, 112)
    @status_window.visible = false
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: create_command_window
  #--------------------------------------------------------------------------
  def create_command_window
    commands = [Vocab::ShopBuy, Vocab::ShopSell, Vocab::ShopCancel]
    @command_window = Window_Command.new(Graphics.width - 160, commands, 3)
    @command_window.y = 56
    @command_window.draw_item(1, false) if $game_temp.shop_purchase_only
  end
  
end # Scene_Shop

#==============================================================================
# ** Scene_Debug
#==============================================================================

class Scene_Debug < Scene_Base
  
  #--------------------------------------------------------------------------
  # alias method: start
  #--------------------------------------------------------------------------
  alias start_scene_debug_ce start unless $@
  def start
    start_scene_debug_ce
    @help_window.height = Graphics.height - @help_window.y
    @help_window.width = Graphics.width - @help_window.x
    @help_window.create_contents
  end
  
end # Scene_Debug

#==============================================================================
# ** Scene_Battle
#==============================================================================

class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # alias method: terminate
  #--------------------------------------------------------------------------
  alias terminate_scene_battle_ce terminate unless $@
  def terminate
    terminate_scene_battle_ce
    if $disposable_battle_windows != nil
      for window in $disposable_battle_windows
        window.dispose unless window.disposed?
      end
      $disposable_battle_windows = []
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: start_main
  #--------------------------------------------------------------------------
  alias start_main_ce start_main unless $@
  def start_main
    @performed_actors = []
    start_main_ce
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: set_next_active_battler
  #--------------------------------------------------------------------------
  def set_next_active_battler
    @performed_actors = [] if @performed_actors == nil
    loop do
      if $game_troop.forcing_battler != nil
        @active_battler = $game_troop.forcing_battler
        @action_battlers.delete(@active_battler)
        $game_troop.forcing_battler = nil
      else
        make_action_orders
        @action_battlers -= @performed_actors
        @active_battler = @action_battlers.shift
      end
      @performed_actors.push(@active_battler) unless @active_battler == nil
      return if @active_battler == nil
      return if @active_battler.index != nil
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: create_info_viewport
  #--------------------------------------------------------------------------
  def create_info_viewport
    @info_viewport = Viewport.new(0, Graphics.height-128, Graphics.width, 128)
    @info_viewport.z = 100
    @status_window = Window_BattleStatus.new
    @party_command_window = Window_PartyCommand.new
    @actor_command_window = Window_ActorCommand.new
    @status_window.viewport = @info_viewport
    @party_command_window.viewport = @info_viewport
    @actor_command_window.viewport = @info_viewport
    @status_window.x = 128
    @actor_command_window.x = Graphics.width
    @info_viewport.visible = false
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: start_skill_selection
  #--------------------------------------------------------------------------
  def start_skill_selection
    @help_window = Window_Help.new
    dh = Graphics.height - @help_window.height - 128
    @skill_window = Window_Skill.new(0, 56, Graphics.width, dh, @active_battler)
    @skill_window.help_window = @help_window
    @actor_command_window.active = false
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: start_item_selection
  #--------------------------------------------------------------------------
  def start_item_selection
    @help_window = Window_Help.new
    dh = Graphics.height - @help_window.height - 128
    @item_window = Window_Item.new(0, 56, Graphics.width, dh)
    @item_window.help_window = @help_window
    @actor_command_window.active = false
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: wait_for_animation
  #--------------------------------------------------------------------------
  def wait_for_animation
    update_basic
    update_basic while @spriteset.animation?
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: display_normal_animation
  #--------------------------------------------------------------------------
  def display_normal_animation(targets, animation_id, mirror = false)
    animation = $data_animations[animation_id]
    if animation != nil
      to_screen = (animation.position == 3)
      ani_check = false
      for target in targets.uniq
        if ani_check
          target.pseudo_ani_id = animation_id
        else
          target.animation_id = animation_id
          target.animation_mirror = mirror
        end
        ani_check = true if to_screen
        wait(20, true) unless to_screen
      end
      wait(20, true) if to_screen
    end
  end
  
end # Scene_Battle

#===============================================================================
# 
# END OF FILE
# 
#===============================================================================